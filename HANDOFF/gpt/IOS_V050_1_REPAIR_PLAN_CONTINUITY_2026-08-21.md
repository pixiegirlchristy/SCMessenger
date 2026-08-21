# IOS-V050-1 repair plan: durable request lifecycle and indefinite delivery — complete continuity snapshot

Status: Snapshot; blocked repair-plan source preserved as evidence; no approval
Last updated: 2026-08-21 HST
Source path: `tmp/orchestration/plans/IOS-V050-1-REPAIR.md`
Source SHA-256: `5f579f6e9f3f2bd577b642042b4f61f840ddf2f5d43287232703737ff52e59b7`
Redaction declaration: Every occurrence of the recorded local repository prefix is deterministically replaced with `<REPO_ROOT>`; source body 420 lines, redactions 0. The body below is otherwise byte-for-byte complete.

# IOS-V050-1 repair plan: durable request lifecycle and indefinite delivery

Status: READY FOR FRESH IMPLEMENTER
Planner role: PLANNER
Original base SHA: `5f052764a713a5932b1d99d51bf6c41e8143c477`
Rejected attempt patch SHA-256: `fc9e5f8afb0960c3c71bf7720522840d716420fb227239caf70ddc1b7da2055a`
Blocking reviews:

- `tmp/orchestration/reviews/IOS-V050-1-CRITICAL.md`
- `tmp/orchestration/reviews/IOS-V050-1-SECOND.md`

## 1. Planning disposition

The first implementation must not be integrated. Both independent reviews
correctly block it on six consequential defects:

1. attempt 12 becomes a lifetime automatic-delivery cutoff;
2. an actor-reentrant flush can overwrite newer queue mutations;
3. request rejection suppresses durable marker-removal failure;
4. the tests cover value helpers rather than repository persistence and races;
5. acknowledged-without-receipt entries become permanently inert after seven
   days; and
6. moderation lookup failure exposes requests by treating unknown as allowed.

No operator decision is needed to resolve the apparent conflict in the first
packet. The active operator-approved field-gate contract in
`HANDOFF/plans/PR139_FIVE_NODE_FIELD_GATE_REFERENCE.md` is controlling:
accepted undelivered work remains an outstanding obligation indefinitely,
individual bursts may be finite, retry is opportunity-driven and backoff-aware,
and only final receipt or a genuinely irreversible terminal condition ends the
obligation. Packet requirement 4 must therefore mean exhaustion of one bounded
automatic burst, not exhaustion of lifetime automatic delivery.

## 2. Replacement, not incremental repair

Dispatch a fresh `PLATFORM_IMPLEMENTER` in a new isolated worktree at the
original base SHA. Use a new isolation ID such as
`writer:IOS-V050-1:attempt:2`. Do not apply or cherry-pick the rejected patch as
a unit. It may be consulted for the independently sound presentation mapping,
but its outbox persistence, exhaustion flag, full-snapshot flush, retry method,
and tests must be replaced.

The implementer owns exactly these paths:

- `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
- `iOS/SCMessenger/SCMessenger/ViewModels/ChatViewModel.swift`
- `iOS/SCMessengerTests/OutboxRetryPolicyTests.swift`

No other path is writable. In particular, do not touch `core/`, Rust, UniFFI
bindings, `Generated/`, public FFI or wire formats, Xcode project files, UI
views, Android, or HANDOFF files. The separate IOS-V050-2 packet owns user
reachability.

## 3. Required production design

### 3.1 One authoritative outbox persistence component

Replace direct `loadPendingOutbox` / `savePendingOutbox` read-modify-write use
with one app-internal persistence component defined in `MeshRepository.swift`
and used by every production queue mutation.

The component must have an injectable persistence driver with two synchronous,
throwing operations:

- read the current encoded bytes, where a missing file means an empty queue;
- atomically replace the encoded bytes.

The production driver reads `pending_outbox.json` and writes with
`Data.write(options: .atomic)`. A decode error is an error, never an empty
queue. No caller may overwrite corrupt or unreadable durable state with `[]`.
Tests use an in-memory byte driver; it is the same encoder, decoder, transaction,
and compare-and-swap code used by production.

Keep the on-disk top-level representation as the existing JSON array to avoid
an unnecessary storage-format migration. Extend `PendingOutboundEnvelope` only
with optional/defaulted app-internal fields:

- `mutationGeneration: UInt64?` (legacy value is zero);
- `retryDeferredUntilEpochSec: UInt64?` (legacy value is nil).

`attemptCount` becomes the consecutive transient-failure count for the current
burst, not a lifetime limit. Preserve `queueId`, `historyRecordId`, peer/route
hints, encrypted envelope bytes, creation time, strict-mode flag, identity and
device constraints, terminal failure code, and acknowledged-without-receipt
count. Synthesized Codable compatibility is acceptable only when proved by a
legacy fixture with neither new key.

Every mutation is a synchronous transaction on the MainActor:

1. decode the freshest durable array;
2. validate unique nonempty queue IDs and history IDs;
3. transform only the intended identity-keyed entries;
4. increment the changed entry's generation with saturating arithmetic;
5. encode and atomically persist the complete fresh array; and
6. return success only after persistence succeeds.

Expose an internal compare-and-swap operation keyed by `queueId` and the
captured generation. A post-await attempt result may update or remove that item
only when the same queue entry still exists at that generation. It must merge
against the freshest array, so unrelated enqueue, removal, promotion, or retry
mutations survive. Missing or stale means discard the old result; it never
recreates or overwrites an entry.

All production mutations must use this component:

- durable enqueue before the first transport attempt;
- receipt/history-sync removal;
- delivered-state cleanup;
- terminal-result persistence;
- transient backoff/defer updates;
- acknowledged-without-receipt updates;
- manual retry-now acceleration;
- peer/route/network/start opportunity promotion; and
- corrupt-envelope quarantine (retain the item with a local nonretryable error,
  never silently drop accepted work).

### 3.2 Reentrant flush and coalescing

Retain one active flush at a time, but replace the drop-on-`outboxFlushInFlight`
behavior with a coalescing request flag. A flush request received while a pass
is awaiting transport sets the flag. The active driver performs one additional
pass after the current pass completes; repeated requests coalesce. This ensures
a manual or opportunity acceleration cannot be lost merely because its delayed
flush fired during an existing pass.

For each item:

1. read an eligible snapshot and capture `(queueId, mutationGeneration)`;
2. mark that queue ID in an in-memory in-flight set;
3. await the existing route resolution and `attemptDirectSwarmDelivery` path;
4. remove it from the in-flight set; and
5. apply the result through the generation-bound compare-and-swap transaction.

The flush must not construct and later persist a whole `nextQueue` snapshot.
Manual retry-now on an item already in flight is idempotent and schedules no
second acceleration. Receipt removal while an attempt is suspended wins and
the old result cannot resurrect it. A new enqueue remains present. Promotion
of another item remains present. Promotion of the in-flight item either waits
for the coalesced next pass or advances its generation so the stale attempt
result cannot overwrite it.

Initial send must close the current nondurable window: persist exactly one
pending envelope before initiating its first network attempt, then run that
same item through the authoritative attempt/commit path. If durable enqueue
fails, do not transmit and report a storage error. Do not create a second
history record, queue ID, or encrypted envelope when retrying.

### 3.3 Indefinite obligation with bounded bursts

The threshold of 12 may remain only as a burst threshold. Rename it accordingly
and remove `pendingOutboxExpiryReason` or any equivalent lifetime-terminal use.

For an unacknowledged transient result:

- attempts 1 through 11 use the existing progressive backoff;
- reaching the burst threshold retains the same queue/history/envelope, marks
  `retryDeferredUntilEpochSec`, and presents retryable deferred failure;
- the defer window is the existing five-minute patient interval plus small
  deterministic jitter derived from stable queue-ID bytes, not Swift
  `hashValue`;
- when the defer window expires and a plausible current route exists, the same
  obligation begins a new burst with consecutive count reset;
- peer identification/reconnection, new address/route, Wi-Fi recovery, service
  start/foreground reconciliation, or manual retry-now clears the defer state,
  resets only the consecutive burst count, and schedules the same entry now;
  and
- if no plausible route exists at timer expiry, retain the entry, move the
  defer window forward, and do not consume a network attempt.

There is no lifetime attempt count, age expiry, silent deletion, or
manual-only recovery for a nonterminal obligation. Manual retry-now accelerates
the same automatic obligation; it does not replace automatic delivery.

Use saturating increments for counters. A final application delivery/read
receipt or peer-reflected history truth removes the obligation. Terminal
`identity_device_mismatch` and `identity_abandoned` remain persisted,
nonretryable, and immune to timer, opportunity, and manual actions.

### 3.4 Acknowledged without final receipt

Transport acknowledgement remains distinct from final recipient delivery.
An acknowledged item:

- remains durably present and presents `sent` / unconfirmed;
- never ages into delivered, failed, or a permanently inert state;
- is not manually retryable through the failed-retry action;
- continues receipt reconciliation on the existing early cadence, then a
  patient capped cadence with deterministic jitter;
- is scheduled immediately by a genuine peer/route/network/start opportunity;
  and
- is removed only by final receipt, peer-reflected history truth, explicit
  cancellation policy, or an irreversible terminal condition.

Delete the seven-day stop helper and its age-ceiling tests. A periodic pass may
skip transmission when no plausible route exists, but the obligation remains
eligible on every later opportunity. Receipt count and age are scheduling
inputs only, never delivery truth.

### 3.5 Truthful presentation and manual acceleration

Retain the internal semantic states `queued`, `stored`, `forwarding`, `sent`,
`delivered`, `failedRetryable`, and `rejectedNonretryable`, with these truth
rules:

- local queued history without an envelope is `queued`;
- a future scheduled envelope is `stored`;
- an eligible/in-flight envelope is `forwarding`;
- any transport acknowledgement without final receipt is `sent`;
- final receipt/history truth is `delivered`;
- a transient envelope in burst defer is `failedRetryable`, while remaining
  automatically eligible later; and
- terminal identity/device or local-envelope corruption is
  `rejectedNonretryable`.

The retryable detail must say that delivery is paused by backoff and will retry
on the next opportunity; it must not say automatic delivery has ended.

`retryFailedMessage(messageId:)` becomes throwing and returns whether it
actually changed the entry. It may accelerate only a transient deferred entry,
preserves queue/history/envelope identity, resets the current burst counter,
sets next attempt to now, increments generation, persists before returning,
publishes one refresh, and requests one coalesced flush. Repeated taps after the
first successful mutation are no-ops. Terminal and acknowledged entries remain
unchanged.

### 3.6 Fail-closed request lifecycle

Make `clearNotificationRequestPending(peerId:)` idempotent and throwing:

- a missing contact or already-absent marker is success without a write;
- unavailable `ContactManager`, contact read failure, contact write failure, or
  flush/persistence failure is surfaced;
- checkpoint/read-notification side effects occur only after the durable
  contact update succeeds.

`acceptMessageRequest` propagates marker persistence failure.

`rejectMessageRequest` follows this exact sequence:

1. obtain current blocked status; moderation lookup failure aborts;
2. if not blocked, invoke the existing block authority;
3. only after confirmed blocked state, clear the marker durably;
4. only after marker success, mark the notification conversation read; and
5. return success.

A block failure leaves the marker unchanged. If block succeeds but marker
persistence fails, the method throws while the peer remains blocked. A later
retry observes the already-blocked state and retries marker removal, which is
the bounded reconciliation path. Successful rejection leaves no durable marker,
so a later unblock cannot resurrect the request.

Keep the existing nonthrowing `getMessageRequests` signature because its UI
caller is outside this packet. Internally, list contacts and check every pending
peer through the throwing moderation authority. If contact listing or any
blocked lookup fails, publish the error and return an empty list for that load.
Never interpret unknown as unblocked and never return a partially checked list.
Blocked peers are omitted.

Provide small internal closure-driven lifecycle helpers for ordering and
filtering only if required for deterministic tests. Production methods must
call those exact helpers; test-only duplicate logic is not acceptable.

### 3.7 Error propagation

Add an app-internal storage/request operation error case or type with a useful
localized description and one repository error subject consumed by
`ChatViewModel`. Persistence and moderation errors must never be reduced to
`false`, `[]` without notification, `try?`, or a success diagnostic.

- public/internal actions that can throw (`enqueue`, retry-now, accept,
  reject, presentation load) propagate the thrown error;
- nonthrowing delegate/event callbacks (receipt removal, history-sync removal,
  opportunity promotion) publish the error, emit an error diagnostic, and
  retain fail-closed state;
- flush stops mutating the affected item on persistence failure, publishes the
  error, and does not emit a successful state transition;
- a terminal-result persistence failure quarantines that queue ID in memory and
  prevents another send until durable reconciliation succeeds; and
- queue decode failure halts outbox processing without overwriting the file.

`ChatViewModel.retryMessage(id:)` catches the thrown error and sets its existing
observable `error`. It also subscribes to the repository operation-error stream
so callback-originated persistence failures are visible. Preserve its existing
`messageUpdates` subscription.

The incidental request-marker cleanup after a successfully accepted outbound
send must publish a request-lifecycle error rather than throw an “unsent” error
that could induce a duplicate user send.

## 4. Deterministic test requirements

Extend only `OutboxRetryPolicyTests.swift`. Tests must invoke the same store,
flush engine, and lifecycle helpers used by production. Inject deterministic
clock, UUID/queue IDs, persistence bytes, route-availability result, and
transport attempt closure. Do not sleep or use real networking.

Required tests:

1. `testLegacyOutboxDecodesWithoutGenerationOrDeferredKeysAndSurvivesRestart`
   decodes a literal legacy JSON array, mutates it, reconstructs the store over
   the same bytes, and preserves queue/history/envelope identity.
2. `testMoreThanTwelveTransientFailuresRemainOneAutomaticObligation` proves one
   item enters bounded defer rather than terminal state, a later timer with a
   plausible route or explicit opportunity starts a new burst automatically,
   and final receipt removes it.
3. `testNoRouteAtDeferredDeadlineRetainsWithoutConsumingAttempt` proves bounded
   no-route reconciliation and no automatic churn.
4. `testSuspendedFlushCannotOverwriteRetryEnqueueReceiptRemovalOrPromotion`
   suspends the real flush attempt with a continuation, interleaves manual
   acceleration, a new enqueue, receipt removal, and peer promotion, resumes the
   old attempt, and proves the stale result is discarded, no mutation is lost,
   no removed item is resurrected, and the coalesced pass runs.
5. `testRepeatedManualRetryTapsScheduleOneAccelerationWithStableIdentity`
   proves exactly one queue/history/envelope and one generation advance.
6. `testTerminalIdentityFailureRemainsNonretryableAcrossOpportunityAndRestart`
   covers both terminal codes and proves manual action is a no-op.
7. `testAcknowledgedWithoutReceiptRemainsSentAndOpportunityEligiblePastSevenDays`
   proves no age-derived delivered/failed/inert result and receipt removal.
8. `testPersistenceFailuresPropagateForEnqueueAttemptCommitAndReceiptRemoval`
   injects write failures and proves no success result or silent overwrite.
9. `testRejectBlockFailureLeavesMarkerAndNeverClears` proves block-first order.
10. `testRejectMarkerFailureIsReportedThenRetryPersistsAbsenceAcrossReload`
    proves block success plus marker failure is observable, retry reconciles,
    and unblock does not resurrect the marker.
11. `testBlockedLookupFailureReturnsNoRequestsAndPublishesError` proves the
    moderation path fails closed rather than exposing a partial list.
12. Preserve and update the pure truth-mapping assertions for queued, stored,
    forwarding, sent, delivered, retryable defer, and terminal rejection.

The controlled interleaving test must fail against the rejected full-snapshot
implementation. Pure value-copy tests alone are insufficient.

## 5. Acceptance criteria mapped to the blockers

- No transient attempt count or message age terminates automatic eligibility.
- Attempt 12 starts a bounded, opportunity-reactivated defer using the same
  durable obligation.
- Acknowledged-without-receipt remains sent/unconfirmed and automatically
  opportunity-eligible beyond seven days.
- Every post-await result is generation-bound and merged into current durable
  state; stale results cannot lose or resurrect work.
- Repeated manual actions create no second message, queue item, envelope, or
  transport schedule.
- Valid receipt/history truth wins every race and prevents retransmission.
- Terminal identity/device failures stay durable and nonretryable.
- Queue read/decode/write errors and request marker errors are observable.
- Rejection is block-first, marker clearing is durable or throws, and successful
  rejection cannot reappear after unblock.
- Moderation uncertainty exposes zero requests.
- The exact three-file diff has no mock-only production behavior, placeholder,
  simulation marker, emoji, generated binding edit, core/Rust edit, or public
  API/wire-contract change.

## 6. Authoritative Mac gates

All output paths stay under the isolated worktree's repo-local `tmp/`. Check the
installed simulator first; do not start or repeat any platform download. If the
named installed destination is unavailable, report the exact blocker to the
controller rather than downloading a runtime.

Device compilation gate:

```text
python3 scripts/build_lock.py --run "xcodebuild -quiet -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessenger -destination 'generic/platform=iOS' -derivedDataPath tmp/xcode-derived-ios-v050-1-repair-device CODE_SIGNING_ALLOWED=NO build" --holder ios-v050-1-repair-device
```

Simulator test gate (the currently installed authoritative destination):

```text
python3 scripts/build_lock.py --run "xcodebuild -quiet test -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessengerTests -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' -derivedDataPath tmp/xcode-derived-ios-v050-1-repair-tests -resultBundlePath tmp/xcode-results/ios-v050-1-repair.xcresult" --holder ios-v050-1-repair-tests
```

Also run scoped `git diff --check`, the forbidden-marker/generated/core scope
scan, and report all warnings and all tests without truncation. Worker-local
gates are advisory until the controller reruns both commands under the shared
build lock against the exact captured patch.

## 7. Required fresh reviews and integration rule

After authoritative gates, capture a new scoped patch SHA-256 and dispatch
fresh, patch-bound, independently isolated assignments for all three required
roles:

- `CRITICAL_VALIDATOR` for delivery, durability, fail-closed moderation, and
  receipt truth;
- `SECOND_OPINION` to confirm the prior plan/review disagreement is actually
  resolved against the field-gate contract; and
- `RELEASE_GATEKEEPER` for exact gate, scope, test inventory, warning, and
  artifact evidence.

Each review assignment must bind the fresh base SHA, patch SHA-256, exact three
files, provider/model/reasoning, reviewer isolation ID, and dispatch reference.
The previous BLOCK reviews cannot approve a different patch. Any implementation
defect returns to a fresh implementer repair and then receives fresh reviews.
Only a patch with all required approvals and controller-rerun authoritative
gates may enter integration.

## 8. Stop and escalation conditions

Stop with `ESCALATION: OPERATOR` if the repair would require changing the
operator-approved indefinite-delivery philosophy, public API, receipt truth,
wire format, identity terminal policy, capacity/backpressure product policy, or
release/version decision. Stop with `ESCALATION: PLANNER` if the three-file
scope cannot provide the production-used deterministic seams. Stop with
`ESCALATION: CRITICAL_VALIDATOR` if safe behavior requires core/Rust,
`Generated/`, or protected crypto/transport/routing/privacy changes.

The UI packet and physical multi-node evidence remain separate required work;
this repair must not claim user reachability or four/five-node field readiness.

---ORCHESTRATION_METADATA---
RESULT: DONE
ROLE: PLANNER
TASK: IOS-V050-1
FILES: ["tmp/orchestration/plans/IOS-V050-1-REPAIR.md"]
VERIFICATION: CONTAINER(read-only review of AGENTS.md, docs/ORCHESTRATION.md, orchestration/manifest.yaml, IOS-V050-1 packet, both bound reviews, exact three-file rejected diff, live outbox/request call sites, field-gate delivery contract, Xcode schemes; python3 scripts/orchestration_contract.py)
SPEC_STATUS: SATISFIED
ESCALATION: NONE
NOTES: ["Fresh replacement worktree required", "Attempt 12 is a bounded opportunity-reactivated burst defer, never a lifetime cutoff", "All queue mutations use generation-bound durable transactions", "Fresh CRITICAL_VALIDATOR, SECOND_OPINION, and RELEASE_GATEKEEPER reviews are mandatory"]
---END---
