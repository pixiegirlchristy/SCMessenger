# IOS-V050-1-REPAIR CRITICAL_VALIDATOR review — complete continuity snapshot

Status: BLOCK preserved; source evidence only; no approval
Last updated: 2026-08-21 HST
Source path: `tmp/orchestration/reviews/IOS-V050-1-REPAIR-CRITICAL.md`
Source SHA-256: `fac415efa3c30085e8c6a54f6c8c3540b8848b8a5c889f5260ccf4f5db4ef677`
Redaction declaration: Every occurrence of the recorded local repository prefix is deterministically replaced with `<REPO_ROOT>`; source body 227 lines, redactions 0. The body below is otherwise byte-for-byte complete.

# IOS-V050-1-REPAIR CRITICAL_VALIDATOR review

Verdict: BLOCK

Assignment: `IOS-V050-1-REPAIR-CRITICAL-20260821-A`

## Bound review scope

- Writer base: `5f052764a713a5932b1d99d51bf6c41e8143c477`
- Supplied and live scoped patch SHA-256:
  `5ffa3a73e260d1df8f6aa10b2713b12788ba84449a3aaf4cfead6d75d02d0c23`
- Reviewed files:
  - `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
  - `iOS/SCMessenger/SCMessenger/ViewModels/ChatViewModel.swift`
  - `iOS/SCMessengerTests/OutboxRetryPolicyTests.swift`
- `shasum -a 256` over the frozen patch and a fresh scoped
  `git diff --binary --no-ext-diff HEAD` both produced the expected hash.
- `git rev-parse HEAD` produced the assigned base SHA.
- `git diff --check HEAD -- <three scoped files>` reported no errors.
- The patch has exactly three diff headers and none is under `core/` or
  `Generated/`. The added-line forbidden-marker scan was empty.
- The frozen result bundle
  `tmp/xcode-results/ios-v050-1-repair-immutable-clean.xcresult` reports
  `Passed`: 62 passed, 0 failed, 0 skipped on iPhone 17 Pro / iOS Simulator
  26.5 build 23F77. A compact, uncapped `xcresulttool` inventory enumerated all
  62 test cases and every result was `Passed`; 18 belong to
  `OutboxRetryPolicyTests`.
- This reviewer did not build, test, install, download, stage, commit, or push.

## Disposition of the six prior blockers

1. **Lifetime attempt-12 abandonment: resolved in the ordinary path.** The
   threshold now ends one burst, records a deterministic five-minute defer,
   and the eight-second periodic pass plus explicit opportunity promotions can
   start another burst. No age or lifetime-attempt deletion remains.
2. **Whole-snapshot actor-reentrant overwrite: substantially resolved, but a
   different same-item generation race remains blocking below.** Queue writes
   now load fresh state and use queue-ID/generation CAS. The controlled test
   proves that enqueue, removal, manual acceleration, and promotion of a
   different entry survive a suspended attempt.
3. **Durable request-marker clearing: not resolved.** The Swift method can
   throw for `add`, but it cannot observe the actual flush failure; finding 2
   gives the concrete path.
4. **Consequential tests: materially improved but still incomplete.** Tests
   invoke the production-used outbox store/engine and lifecycle ordering
   helpers. They do not cover the same-item result race, real contact-store
   durability, reachable request-screen behavior, or repository send/history
   acceptance.
5. **Acknowledged-without-receipt age cutoff: resolved in the ordinary path.**
   The seven-day terminal/inert helper is gone; an acknowledged entry remains
   `sent`, gets patient scheduling, and is opportunity eligible. Finding 1 can
   still discard a newly received transport acknowledgment during a race.
6. **Moderation lookup uncertainty: locally fail-closed but not end-to-end
   fail-closed.** The repository returns no request threads and publishes an
   error, but the reachable caller converts that empty set into normal-inbox
   exposure and does not display the error; finding 3 is blocking.

## Blocking findings

### 1. An opportunity promotion of the in-flight item discards ACK and terminal truth

`retryNow` explicitly refuses an in-flight queue ID at
`MeshRepository.swift:401-405`, but `promote` and `promoteAllForOpportunity`
do not apply that guard at lines `415-463`. Both may reset the same in-flight
entry and advance its generation while `attemptTransport` is suspended at
lines `557-559`. When the attempt returns, lines `573-577` treat the now-stale
generation as a reason to discard the complete result, without distinguishing
a transient failure from an ACK or irreversible terminal response.

A reachable sequence is:

1. a due item with a nonzero consecutive-attempt count begins transport;
2. peer identification, connection, Wi-Fi recovery, service start, or
   foreground reconciliation promotes that same item and advances generation;
3. transport returns an ACK or `identity_device_mismatch` /
   `identity_abandoned`;
4. CAS returns `.stale`, so neither sent/unconfirmed state nor the terminal
   rejection is persisted; and
5. the coalesced pass can transmit again.

This violates acknowledgment truth and the requirement that terminal identity
conditions become durable and nonretryable. The race test at
`OutboxRetryPolicyTests.swift:393-466` removes the active item and promotes a
different item; it never promotes the active item. The terminal test at lines
`499-535` starts with an already-terminal envelope, so it never proves that a
terminal transport result wins or is quarantined during concurrent promotion.

The repair needs a result-merge rule that preserves receipt/removal as the
strongest truth, safely commits ACK/terminal results across scheduling-only
generation changes, and never lets an old transient result overwrite a newer
manual or opportunity mutation. A blanket stale-result discard is not enough.

### 2. Request rejection still reports durable success through a flush API that suppresses failure

`clearNotificationRequestPending` calls throwing `contactManager.add` and then
the nonthrowing `contactManager.flush()` at `MeshRepository.swift:3945-3951`.
The underlying bridge inserts at `core/src/contacts_bridge.rs:133-144`, while
its `flush` discards the `db.flush()` result at lines `362-365`. The subsequent
checkpoint also calls the same nonthrowing flush at
`MeshRepository.swift:2261-2265`; its backup helper logs its own failure rather
than returning it.

Therefore `rejectMessageRequest` can still return success after block
confirmation even though the marker has not been made crash-durable. A later
restart/unblock can resurrect it. The tests do not exercise this production
authority: `OutboxRetryPolicyTests.swift:65-89` defines a separate
`MemoryRequestMarkerBytes`/`RequestMarkerStore`, and lines `619-669` inject
failure only into that fake writer. Passing those tests does not prove the
real contact-store flush contract.

Because the current three-file packet cannot make the generated/Rust flush
surface throwing, this requires fresh planning: either a separately durable,
reconcilable app marker authority inside approved Apple scope or a coordinated
core/FFI contract change through the protected Windows audit gate. It cannot
be silently treated as solved.

### 3. Moderation failure exposes pending senders in the normal conversation list and hides the error

On any moderation lookup failure, `getMessageRequests` publishes an error and
returns `[]` at `MeshRepository.swift:4484-4523`. The reachable main-inbox
caller builds `requestPeerIds` from that result and includes every contact not
in the set at `MainTabView.swift:237-265`. An empty fail-closed request result
therefore makes all pending-request contacts eligible for the normal
conversation list, including the peer whose blocked status was unknown.

The requests screen also calls the nonthrowing method at
`MainTabView.swift:365-367` but does not subscribe to `operationErrors`; its
local error state is only set by the Accept action at lines `342-349`. The
observable result of a moderation/store failure is consequently “No Message
Requests,” while a pending sender can appear in the ordinary inbox. The only
new `operationErrors` consumer is `ChatViewModel.swift:154-160`, which is not
the request-list owner.

This is a privacy/moderation fail-open at the reachable call site, not merely a
future UI-polish gap. It needs an explicit success/failure request-load result
or UI-side state that withholds pending contacts from both surfaces and shows
the error. That likely expands the packet into the separately planned UI files
and requires fresh scoped implementation and review.

### 4. Initial-send acceptance still suppresses history persistence failure

The field-gate contract distinguishes durable history from the delivery
obligation. The changed send path still performs
`try? historyManager?.add(record:)` and a nonthrowing flush at
`MeshRepository.swift:2473-2486`, then durably enqueues and transmits at lines
`2488-2520`. If `HistoryManager` is unavailable or `add` throws, the message can
be accepted into the encrypted outbox and sent with no durable plaintext
history record. After restart, the sender can lose the visible message/content
while its obligation continues, and no storage error is published.

The added tests instantiate the outbox engine directly; none invokes the
production `sendMessage` acceptance path or injects a history write failure.
Durable-before-network is proved only for the encrypted envelope, not for the
history lifecycle that the active contract requires. The history write must be
required and observable before acceptance, with a deterministic test proving
that its failure prevents outbox enqueue and transport.

### 5. The per-item full-file transaction design creates quadratic main-actor disk work for an indefinite queue

Every transaction loads the full JSON array and atomically rewrites the full
array at `MeshRepository.swift:165-191`. `runPass` loads all snapshots at line
`471` and applies at least one such CAS for each eligible entry, including
no-route deferral and every attempt result. With `N` simultaneously eligible
retained obligations, one pass performs `N` full-array decode/encode/write
cycles: quadratic bytes processed/written. These synchronous operations run on
the MainActor. The periodic loop requests a pass every eight seconds at lines
`5749-5759`, and the governing contract intentionally permits the retained
queue to grow indefinitely until terminal truth.

The rejected code's CPU-watchdog comment motivated yielding between entries;
the new engine still yields, but each individual full-array transaction blocks
the actor. No test or evidence bounds queue size, write amplification, UI
latency, or restart decode cost. This design can turn correct indefinite
retention into an iOS watchdog/storage-churn failure. The repair needs a
bounded-write transactional representation or authoritative load/soak evidence
at a planner-approved maximum; silently capping or deleting obligations is not
an acceptable remedy.

## Additional observations

- Legacy JSON without generation/defer keys decodes and survives a store
  reconstruction in the production-used persistence component.
- Decode errors stop the engine before a write, and invalid base64 is converted
  to a retained local terminal code. Those paths are sound by inspection, but
  no corrupt-file/envelope test is present; the declared `failReads` seam is
  unused.
- Receipt/history removal uses the same store and wins the tested stale-attempt
  race. Manual acceleration retains queue ID, history ID, and ciphertext and is
  idempotent for repeated taps.
- The scoped diff introduces no Rust/core/generated/wire-format change. Its new
  delivery/request interfaces are app-internal. User-visible delivery glyphs,
  retry controls, and request rejection remain outside this patch and must not
  be claimed reachable yet.
- `PendingOutboxFlushEngine.snapshot()` has no call site, and the associated
  value of `.applied` is never consumed. These are small dead surfaces in an
  unusually large patch and should be removed during repair, though they are
  not independent blockers.
- The simulator result is valid regression evidence, but it does not establish
  physical multi-node behavior, signing, distribution, or UI reachability.

## Required repair evidence

1. A controlled same-item in-flight promotion test for transient, ACK, terminal,
   and receipt results, proving ACK/terminal truth is not discarded and receipt
   removal cannot be resurrected.
2. Production-used request-marker persistence evidence whose flush failure is
   observable, plus restart/unblock reconciliation against the real authority.
3. A reachable moderation-failure test proving the peer appears in neither the
   request list nor normal inbox and the owning screen displays the error.
4. A production send-path test proving history failure prevents both outbox
   acceptance and transport.
5. A deterministic corrupt-read/no-overwrite test and terminal commit-failure
   race test.
6. A planner-approved large-queue gate proving bounded MainActor latency and
   write amplification without expiring accepted obligations.

---ORCHESTRATION_METADATA---
RESULT: BLOCKED
ROLE: CRITICAL_VALIDATOR
TASK: IOS-V050-1-REPAIR
ASSIGNMENT_ID: IOS-V050-1-REPAIR-CRITICAL-20260821-A
FILES: ["iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift", "iOS/SCMessenger/SCMessenger/ViewModels/ChatViewModel.swift", "iOS/SCMessengerTests/OutboxRetryPolicyTests.swift"]
VERIFICATION: CONTAINER(read-only complete frozen-patch review; verified base and SHA-256 binding against live scoped diff; git diff --check; inspected governing field-gate contract, prior blocks, repair plan, production call sites, core contact flush contract, complete 62-test xcresult inventory; no build or test run)
SPEC_STATUS: NOT_SATISFIED
ESCALATION: PLANNER
NOTES: ["Same-item opportunity promotion can discard ACK and terminal transport truth", "Request marker flush failure remains unobservable through the real contact authority", "Moderation failure leaks pending contacts into the normal inbox and is not visible in the request screen", "Initial send suppresses history persistence failure", "Full-array per-item transactions create quadratic MainActor storage work"]
---END---
