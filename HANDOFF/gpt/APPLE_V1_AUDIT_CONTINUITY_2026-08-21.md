# APPLE-V1-AUDIT — iOS/macOS State Through v1.0.0 — complete continuity snapshot

Status: Snapshot; source evidence only; no release-readiness claim
Last updated: 2026-08-21 HST
Source path: `tmp/orchestration/evidence/APPLE-V1-AUDIT.md`
Source SHA-256: `c5d5fcc574cedeaf51cdaa0e63f120bc26f0bf854e58da833d46cc3d1a2214b7`
Redaction declaration: Every occurrence of the recorded local repository prefix is deterministically replaced with `<REPO_ROOT>`; source body 1133 lines, redactions 1. The body below is otherwise byte-for-byte complete.

# APPLE-V1-AUDIT — iOS/macOS State Through v1.0.0

Status: Read-only evidence inventory
Audit opened: 2026-08-21T07:06:22Z
Closing ref/provenance sweep: 2026-08-21T07:24:50Z
Role: SCANNER
Repository: `<REPO_ROOT>`

## 1. Audit boundary and snapshot

This artifact reconciles the live Apple source, canonical release documents,
Apple task packets, Android comparison source, active orchestration state, and
all locally available git refs. It does not implement, validate, merge, or
authorize work.

Observed repository snapshot:

- Checked-out branch: `gpt/v050-parity-burndown`.
- `HEAD`: `5f052764a713a5932b1d99d51bf6c41e8143c477`.
- At the source-inspection start, `upstream/main` was
  `5f052764a713a5932b1d99d51bf6c41e8143c477`.
- During the audit the shared ref advanced to
  `8663a149ce3e9110e4bb0a6d24682a8f8faff7ed` through PR #201. The full
  `5f052764..8663a149` name diff contains only `HANDOFF/CTO_STATE.md`; the
  inspected application source candidate remains HEAD `5f052764...`.
- `origin/gpt/v050-parity-burndown`:
  `5f052764a713a5932b1d99d51bf6c41e8143c477`.
- HEAD subject: `Merge pull request #200 from 3rdkey/claude/...`.
- HEAD commit timestamp: `2026-08-20T17:06:52-10:00`.
- The checkout contained unrelated working-tree changes. The live Apple source
  inspected here was unchanged except for already-present changes to
  `iOS/README.md` and `iOS/XCODE_SETUP.md`; this scanner did not alter them.
- Latest reviewed coordination ref: `upstream/main` at `8663a149...`, plus the
  one-commit branch `upstream/cto/four-node-parity-kickoff-2026-08-21` at
  `3289fa5d15eb6b4e631e5830e477030886799e54`.
- The only file written by this scanner is this ignored evidence file under
  `tmp/`.
- No `xcodebuild`, `cargo`, Gradle, physical-device run, archive, upload, or
  distribution action was performed by this scanner. Historical results are
  labeled with their source and candidate.

Classification used below:

| Label | Meaning |
|---|---|
| `[IMPLEMENTED]` | Live code and a reachable call path were read at HEAD. This does not imply device proof. |
| `[MISSING]` | Required or requested behavior/configuration was absent from the inspected source. |
| `[ACTIVE-UNINTEGRATED]` | A dispatched task exists outside the current integrated candidate. |
| `[OPERATOR-GATED]` | Requires an operator account, decision, credential, release action, or rule-9 decision. |
| `[HARDWARE-GATED]` | Requires physical-device or multi-node evidence not present for this candidate. |
| `[WINDOWS/CORE-OWNED]` | The authoritative change or build gate is reserved to the Windows/core lane. |
| `[SCOPE-AMBIGUOUS]` | Current canonical documents do not settle whether the item belongs in v1.0.0. |
| `[STALE-DOC]` | A packet's factual premise is contradicted by current source. |
| `[UNPROVEN]` | Source exists, but the required runtime, integration, or release evidence was not found. |

## 2. Executive finding

The Apple lane is not presently evidence-complete for v1.0.0. The iOS app has
a substantial live implementation: the shared Rust node is bridged into the
app, foreground swarm startup is wired, dual mDNS browsing is present,
Bluetooth LE central/peripheral transports are reachable, Multipeer transport
is started, ledger bootstraps are passed to core, encrypted receipts are
handled, local notification actions are wired, background task registration is
reachable, QR identity/import flows exist, and core-derived diagnostics are
exposed.

The remaining gaps are not one category of work. They include:

- app behavior that is genuinely missing or dead at HEAD, including visible
  delivery state, manual retry, reject/block actions from the request inbox,
  external deep links, inbound share, remote notification delivery, and
  release assets/configuration;
- a currently dispatched but unintegrated iOS moderation/outbox task;
- operator-gated signing, App Store Connect/TestFlight, distribution, and
  product-scope decisions;
- hardware-gated Bluetooth, Multipeer, background, notification, custody,
  four/five-node, and cross-platform receipt evidence;
- Windows/core-owned finite retry, contact recovery, cryptographic/privacy,
  and authoritative cross-platform build work;
- a native macOS product whose v1.0.0 scope and stack are not established by
  the canonical plan and whose target does not exist in the live project;
- branch-separated CAO and CTO records that are not all present in any one
  reviewed branch.

Android is not a completed reference for every requested parity behavior. Its
request rejection and blocked-peer surfaces are ahead of iOS, and its APK
sharing/inbound-share paths exist, but its live chat bubble also omits delivery
state, its retry helpers are not called by the UI, its request loader drains
received messages destructively, and current cross-platform finite-abandonment
and contact-recovery defects remain Windows/core work.

## 3. Canonical scope and sequencing reconciliation

### 3.1 Current shipping sequence

- `[IMPLEMENTED]` `SHIP_PLAN.md:6-9` states that the ship plan is the
  current authority until the v0.4.0 tag and that only the queue is eligible
  for dispatch.
- `[HARDWARE-GATED]` `SHIP_PLAN.md:26-31` keeps D4/D6/D7 in the active
  sequence. The inspected state did not contain current-candidate completion
  evidence for D6/D7.
- `[UNPROVEN]` `SHIP_PLAN.md:123-131` records that the clean five-node
  gate never ran.
- `[IMPLEMENTED]` `SHIP_PLAN.md:160-165` places iOS parity after the
  v0.4.0 tag. This means a request to finish Apple work ahead of the tag does
  not itself change canonical dispatch order.
- `[HARDWARE-GATED]` The latest merged CTO record at
  `upstream/main` `8663a149...`, `HANDOFF/CTO_STATE.md:76-86`, retains D6/D7
  hardware proof and then the tag/queue order. The later branch-only CTO
  four-node packet explicitly proposes absorbing D4/D6/D7 into one gate; see
  Section 15.4.

### 3.2 Version boundaries

- `[IMPLEMENTED]` `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:163-169` excludes iOS from
  the v0.4.0 milestone.
- `[IMPLEMENTED]` `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:246-250` excludes iOS
  distribution from v0.5.0.
- `[IMPLEMENTED]` `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:254-259` establishes the
  v1.0.0 product goal.
- `[IMPLEMENTED]` Apple work packages C1-C5 and U6 are listed at
  `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:313-327`.
- `[HARDWARE-GATED]` Meeting Mode and its cross-platform exercise are listed at
  `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:328-345`.
- `[IMPLEMENTED]` The KMP desktop plan at
  `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:346-367` is Linux/WSL-oriented. It does
  not specify a native macOS GUI target.
- `[HARDWARE-GATED]` Drills and release closeout are listed at
  `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:392-403` and
  `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:414-420`.
- `[SCOPE-AMBIGUOUS]` `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:279-283` places PQC-09
  in v1.0.0, while `HANDOFF/plans/MILESTONE_RELEASE_PLAN.md:435-445` defers live
  cover/padding/timing behavior, onion live wiring, and full Multipeer
  integration to v1.1.0. The current iOS settings surface presents several of
  those controls as available. This conflict needs a durable operator scope
  disposition; the audit does not choose one.

### 3.3 v1 execution-plan status

- `[IMPLEMENTED]` `HANDOFF/V1_0_0_EXECUTION_PLAN.md:4-7` says that plan is
  superseded until the current tag/ship sequence releases it.
- `[WINDOWS/CORE-OWNED]` The same plan states at line 20 that Phase 2 blocks
  shipment and at line 24 preserves the security-review gate.
- `[OPERATOR-GATED]` `HANDOFF/V1_0_0_EXECUTION_PLAN.md:51-53` assigns the iOS
  farm gate and TestFlight action to a human/operator boundary.
- `[OPERATOR-GATED]` `HANDOFF/todo/_QUEUE.md:484` says GitHub billing was
  resolved on 2026-07-23, making older C1 descriptions of that blocker stale.
- `[OPERATOR-GATED]` `HANDOFF/todo/_QUEUE.md:485-491` still records the iOS
  v1 gate/distribution as human work and sequences C3 after PQC-10.
- `[HARDWARE-GATED]` `HANDOFF/plans/FARM_FINAL_PLAN.md:23-28` says more than half of
  target users are on iPhone and makes iOS v1-blocking.
- `[OPERATOR-GATED]` `HANDOFF/plans/FARM_FINAL_PLAN.md:240-251` requires Apple build,
  verification, and TestFlight evidence.
- `[HARDWARE-GATED]` `HANDOFF/plans/FARM_FINAL_PLAN.md:329-347`, `:357-363`, and
  `:425-447` define cross-platform workspace, L2CAP, and drill evidence not
  present for the current candidate.
- `[IMPLEMENTED]` `HANDOFF/plans/FARM_FINAL_PLAN.md:405-407` requires honest state
  reporting rather than treating source presence as completion.

## 4. Live iOS implementation already present

### 4.1 App entry and navigation

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/SCMessengerApp.swift:10-63` is the live app
  entry. It constructs the repository and enters `MainTabView`; the compiled
  `ContentView.swift` sample is not the app entry.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/SCMessengerApp.swift:66-107` invokes app
  setup, notification setup, and background lifecycle handling.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift:31-76` registers the live
  tab destinations.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift:95-123` connects internal
  notification navigation to a conversation.

### 4.2 Node startup, discovery, and transports

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:784-919` starts the
  shared Rust node and the Apple transport/discovery adapters.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/mDNSServiceDiscovery.swift:17-34` browses
  both service families used for compatibility.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/mDNSServiceDiscovery.swift:73-129`
  advertises service metadata, including TXT and `dnsaddr` information.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/mDNSServiceDiscovery.swift:194-269`
  contains validation, self-filtering, and loopback handling. The user packet's
  request for dual mDNS discovery is already represented in current source.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:945-991` wires mDNS
  addresses into node startup and advertises the TCP service.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:986-992` passes ledger
  bootstraps to core.
- `[IMPLEMENTED]` `core/src/transport/swarm.rs:5239-5278` contains the current
  platform-neutral ledger-sharing startup path on connection. Older statements
  that mobile never initiates ledger exchange are stale for this candidate.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/SmartTransportRouter.swift:231-375` races
  reachable transport closures; the repository calls it in the live send path
  around `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:4974-4980`.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:858-867` starts
  Multipeer and Bluetooth LE transport managers.
- `[IMPLEMENTED]` The current Settings UI exposes only Bluetooth LE and
  Internet/Swarm transport toggles at
  `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift:488-505`;
  nearby Apple discovery is described as automatic. The older planning claim
  that WiFi Aware/Direct toggles are still visible is stale for this HEAD.
- `[IMPLEMENTED]` Those two toggles drive live start/stop actions through
  `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:39-63` and
  `:3233-3261`; this is a reachable behavior, not persistence-only UI.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/MultipeerTransport.swift:61-103` configures
  encrypted Multipeer sessions with required encryption.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Transport/MultipeerTransport.swift:390-434` connects
  invitations and peer discovery into the session path.
- `[IMPLEMENTED]` Bluetooth central and peripheral fragmentation/reassembly
  paths exist at `iOS/SCMessenger/SCMessenger/Transport/BLECentralManager.swift:259-280`,
  `iOS/SCMessenger/SCMessenger/Transport/BLECentralManager.swift:585-619`,
  `iOS/SCMessenger/SCMessenger/Transport/BLEPeripheralManager.swift:348-369`, and
  `iOS/SCMessenger/SCMessenger/Transport/BLEPeripheralManager.swift:532-577`.
- `[IMPLEMENTED]` The Apple Bluetooth UUIDs match the DF01-DF04 service and
  characteristic family used by the shared mobile design.

### 4.3 Receipts, custody, and outbox plumbing

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/CoreDelegateImpl.swift:176-195` receives
  the core callback used for receipt handling.
- `[IMPLEMENTED]` `core/src/iron_core.rs:1909-1939` creates the encrypted
  receipt envelope used by the shared implementation.
- `[IMPLEMENTED]` `iOS/SCMessengerTests/ReceiptUnificationTests.swift:21-80`
  exercises the intended unified receipt contract at unit-test level.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:5580-5790` contains
  automatic retry, persistence, acknowledgment handling, retention of selected
  terminal identity errors, and atomic state updates.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:202-205` currently
  configures a 12-attempt/seven-day finite retry boundary.
- `[UNPROVEN]` Source-level receipt unification is not equivalent to a physical
  iOS-to-Android/Windows delivery-and-receipt proof for this HEAD.

### 4.4 Background support

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/MeshBackgroundService.swift:29-47`
  contains the live background-work coordinator.
- `[IMPLEMENTED]` Registration and scheduling are reachable at
  `iOS/SCMessenger/SCMessenger/Services/MeshBackgroundService.swift:52-141`; task handlers are at
  `:145-205`.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Info.plist:5-9` declares the background task
  identifiers and `iOS/SCMessenger/SCMessenger/Info.plist:50-56` declares Bluetooth,
  fetch, and processing background modes.
- `[IMPLEMENTED]` CoreBluetooth restoration identifiers/options and restoration
  callbacks exist in the central/peripheral implementation.
- `[IMPLEMENTED]` The service header at
  `iOS/SCMessenger/SCMessenger/Services/MeshBackgroundService.swift:7-10` accurately states that
  iOS does not provide an Android-style persistent foreground service.

### 4.5 Local notifications

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:51-74` requests
  local notification authorization.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:79-121` builds
  local message notifications.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:199-229`
  registers categories/actions.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:234-300` handles
  reply, read, and tap actions, and the internal route is reachable from the
  app entry.

### 4.6 QR, contacts, diagnostics, and privacy manifest

- `[IMPLEMENTED]` Identity QR display/copy and QR import flows are present in
  the live SwiftUI source.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Views/Topics/JoinMeshView.swift:146-181` parses the
  current join-mesh JSON and imports/dials its seed addresses and topics.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Views/Settings/DiagnosticsView.swift:218-222` exposes a
  system share sheet for diagnostics output.
- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/PrivacyInfo.xcprivacy:5-44` is present and
  declares the inspected privacy-manifest entries.

## 5. iOS behavior gaps and unreachable features

### 5.1 Request moderation and blocked identities

- `[MISSING]` The reachable requests UI at
  `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift:311-368` offers Accept but no Reject and
  no Block-and-delete action.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:3659-3675` returns pending
  request contacts/history without excluding blocked identities.
- `[IMPLEMENTED]` Accept clears the pending marker at
  `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:3729-3732`.
- `[IMPLEMENTED]` Repository block/unblock APIs exist at
  `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:3765-3816`.
- `[MISSING]` Exhaustive call-site search found no reachable SwiftUI caller or
  blocked-identities management screen for those iOS APIs.
- `[ACTIVE-UNINTEGRATED]` `tmp/orchestration/state/IOS-V050-1.json` records a
  dispatched writer task whose integration state was `NOT_STARTED` and review
  state `OUTSTANDING`. `tmp/tasks/IOS-V050-1.dispatch.md` scopes request
  rejection, delivery presentation, outbox persistence, and manual retry. It
  is not part of the HEAD audited above and must not be reported as implemented.

### 5.2 Delivery state and manual retry

- `[MISSING]` The live chat bubble at
  `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift:513-546` intentionally renders no delivery
  state.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/ViewModels/ChatViewModel.swift:107-114` defines a
  `statusGlyph`, but exhaustive references found no reachable use.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:3371-3411` defines
  `deliveryStatePresentation`, but exhaustive references found no reachable
  use.
- `[MISSING]` No reachable manual retry affordance/API was found at HEAD.
- `[IMPLEMENTED]` The generated status type at
  `iOS/SCMessenger/SCMessenger/Generated/api.swift:8518-8523` has queued, in-custody, sent,
  and delivered states.
- `[MISSING]` That type does not expose failed or read states requested by the
  parity packet.
- `[MISSING]` Current retry behavior can remove an aged, unacknowledged item as
  `delivered_unconfirmed` or stop after the finite boundary; the live UI does
  not expose that distinction to the user.

### 5.3 Compose and sample/dead UI

- `[MISSING]` The compose toolbar action at
  `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift:185-191` is an empty closure.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/ContentView.swift` remains in the application
  target as the template Hello-world screen, but the app entry does not call
  it. Its presence is not a feature.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Views/NotificationGuidanceView.swift` and
  `iOS/SCMessenger/SCMessenger/ContactManagerFix.swift` were not registered in the Xcode
  project and had no reachable callers.

## 6. Notifications, deep links, and share flows

### 6.1 Remote notification delivery

- `[MISSING]` No APNs entitlement, `aps-environment`, push-token registration,
  device-token callback, remote-notification background mode, or notification
  service extension was found.
- `[MISSING]` The inspected notification system is local-only. It does not
  establish terminated-app remote delivery/wake.
- `[UNPROVEN]` Local reply/read/tap actions have source and unit-level paths,
  but no current-candidate physical-device notification action evidence was
  found.

### 6.2 Notification privacy

- `[MISSING]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:79-121` places message
  plaintext in the local notification preview. No privacy toggle/redaction
  mode was found.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift:265-275` logs the
  quick-reply plaintext and the full peer identifier. That is a privacy defect,
  not merely a missing test.
- `[WINDOWS/CORE-OWNED]` Any correction that changes shared privacy or
  cryptographic contracts remains subject to the core/security governance in
  Section 14; an Apple-only UI/log correction does not waive those gates if it
  also touches core.

### 6.3 External links and inbound sharing

- `[MISSING]` `Info.plist` has no `CFBundleURLTypes` entry and no Associated
  Domains entitlement.
- `[MISSING]` No application `onOpenURL`/external URL handler or AppDelegate
  deep-link call path was found.
- `[MISSING]` No iOS Share Extension target, inbound shared-text/URL/file
  receiver, or app-group handoff was found.
- `[IMPLEMENTED]` The diagnostics export sheet and QR-based in-app import do not
  substitute for an inbound system share extension.
- `[OPERATOR-GATED]` `HANDOFF/archive/APP_SHARING_IOS_PARITY_CROSS_INSTALL_2026-08-05.md:1-15`
  and `:30-73` record the unresolved Apple distribution choice between
  TestFlight and Ad Hoc-style delivery. The app cannot distribute another iOS
  app artifact the way Android can send an APK without an operator-selected,
  Apple-compliant distribution contract.

## 7. Accessibility, localization, and product presentation

- `[MISSING]` Exhaustive search of non-generated Swift found no localization
  resource (`.strings`, `.stringsdict`, `.xcstrings`, or `.lproj`) and no
  explicit localization API usage.
- `[MISSING]` A syntactic SwiftUI scan found 209 hard-coded string-call matches
  across 17,584 non-generated Swift lines. This is a heuristic inventory, not
  a claim that every match requires translation.
- `[MISSING]` Exhaustive search found no explicit SwiftUI accessibility
  modifiers such as labels, hints, values, identifiers, traits, or sort
  priorities in the app source.
- `[MISSING]` Icon-only compose/send controls therefore have no inspected
  explicit accessibility label.
- `[MISSING]` No UI test target, accessibility test, Dynamic Type test,
  VoiceOver evidence, right-to-left test, localization test, or screenshot
  matrix was found.
- `[SCOPE-AMBIGUOUS]` Current documentation describes an English-only alpha;
  it does not clearly declare full localization a v1.0.0 ship gate. This audit
  records the absence and does not promote it into settled scope.
- `[MISSING]` The asset catalog contains only JSON metadata in the inspected
  tree. `AppIcon.appiconset/Contents.json` has three slots without image
  filenames, and no LaunchScreenBackground image asset was found even though
  `iOS/SCMessenger/SCMessenger/Info.plist:57-61` names that launch-screen background.

## 8. Background-execution evidence gap

- `[IMPLEMENTED]` Registration, scheduling, and handlers exist and are
  reachable as described in Section 4.4.
- `[UNPROVEN]` `iOS/SCMessenger/SCMessenger/Services/MeshBackgroundService.swift:208-237` contains
  debug simulation helpers; simulator invocation is not proof of iOS scheduler
  execution.
- `[UNPROVEN]` `iOS/SCMessenger/SCMessenger/Background/NotificationBackgroundProcessor.swift:37-45`
  simulates background fetch, `:69-80` infers support, and `:163-170` simulates
  network/power conditions. Exhaustive call-site search found production
  inclusion in the app target but only test callers for this processor.
- `[HARDWARE-GATED]` No current-candidate physical evidence was found for
  Bluetooth state restoration, BackgroundTasks launch, background receipt,
  suspended custody, notification action handling, or recovery after process
  termination.
- `[HARDWARE-GATED]` iOS platform limits mean the source must not be described
  as providing Android-style continuously resident background custody. The
  canonical Meeting Mode gate uses foreground operation.

## 9. Discovery and transport gaps

### 9.1 mDNS and advertised endpoint

- `[IMPLEMENTED]` `Info.plist:26-44` includes local-network permission text and
  Bonjour declarations for `_p2p._udp`, `_scmesh._tcp`, `_scmesh._udp`, and
  `_scmessenger._tcp`.
- `[IMPLEMENTED]` Dual mDNS browse/advertise code is reachable.
- `[UNPROVEN]` The inspected startup path at
  `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:945-991` advertises/listens on TCP 9001.
  No current-device evidence demonstrates propagation of an actual dynamic
  bound port when that port cannot be used.

### 9.2 Bluetooth LE robustness

- `[MISSING]` The Apple BLE fragmentation/reassembly implementation did not
  contain a CRC, reassembly timeout, total-fragment/index cap, per-peer memory
  cap, or process-wide reassembly memory cap in the inspected paths.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Transport/BLECentralManager.swift:687-711` contains a
  synchronous characteristic-read helper whose semaphore is never signaled and
  whose success flag is never mutated. Exhaustive references found no caller;
  it is both unreachable and nonfunctional as written.
- `[MISSING]` `validateConnection` in the central manager had no caller outside
  its declaration.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Transport/BLEL2CAPManager.swift` is compiled by the Xcode
  project but exhaustive references found no constructor/call site outside its
  own declarations. L2CAP is therefore not wired merely because the file
  exists.
- `[HARDWARE-GATED]` No current-candidate iPhone-to-Android/iPhone/macOS BLE
  payload, fragmentation, restoration, reconnect, or sustained-load evidence
  was found.

### 9.3 Multipeer

- `[IMPLEMENTED]` Multipeer browse/invite/session/send/receive paths exist with
  required encryption.
- `[MISSING]` `MultipeerTransport` initializes its display name once, with a
  generic `SCMesh` fallback. A source comment mentions later beacon identity
  updates, but exhaustive search found no update/reinitialization call path.
- `[HARDWARE-GATED]` No current-candidate two-iPhone Multipeer discovery,
  transfer, background/foreground transition, or cross-transport fallback
  evidence was found.
- `[SCOPE-AMBIGUOUS]` Full Multipeer integration is deferred to v1.1.0 in one
  canonical section while the v1 Meeting Mode/farm language depends on Apple
  local connectivity. The audit does not resolve this conflict.

### 9.4 Join-mesh parser

- `[IMPLEMENTED]` The join flow is reachable and requires user action inside
  the app.
- `[MISSING]` `iOS/SCMessenger/SCMessenger/Views/Topics/JoinMeshView.swift:146-181` accepts an unsigned
  JSON bundle and did not show a signature, topic/address count bound, or
  explicit policy validation in the inspected parser.
- `[WINDOWS/CORE-OWNED]` If transport hints become an authenticated identity or
  shared invite-contract change, the contract belongs to core/Windows and the
  approval/security gates in Section 14 apply.

## 10. Security and privacy reconciliation

- `[IMPLEMENTED]` Multipeer requests encrypted sessions, core constructs
  encrypted receipts, and the Apple privacy manifest is present.
- `[MISSING]` Notification plaintext/full-peer logging and plaintext previews
  are live privacy defects as documented in Section 6.2.
- `[MISSING]` Join-bundle parser bounds/signature policy are not present in the
  inspected Apple parser.
- `[MISSING]` BLE fragment resource bounds/integrity checks were not present in
  the inspected Apple reassembly paths.
- `[SCOPE-AMBIGUOUS]` `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift:573-632` presents
  Onion, Cover, Padding, and Timing privacy controls. The view model persists
  all of them at `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift:353-390`.
- `[IMPLEMENTED]` Cover traffic itself is reachable from
  `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift:872` and the loop at `:4880-4898`.
- `[MISSING]` Exhaustive source search found no corresponding live runtime
  consumer for the Apple onion, padding, or timing settings. Those controls are
  storage/UI-only at the inspected HEAD.
- `[SCOPE-AMBIGUOUS]` Canonical v1.1 deferrals conflict with the current UI and
  partial cover implementation. Any semantic correction touching
  `core/src/privacy`, `core/src/crypto`, `core/src/transport`, or
  `core/src/routing` requires the repository's independent adversarial review
  and cannot be completed or approved by this Apple scanner.

## 11. Xcode project, packaging, and distribution

### 11.1 Targets and signing configuration

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj:351-389` defines
  the application and unit-test targets.
- `[MISSING]` No UI-test, Share Extension, Notification Service Extension,
  widget, macOS app, or Mac Catalyst target was found.
- `[IMPLEMENTED]` The project contains automatic signing metadata with team
  `JSZ36WH4C8`, bundle identifier
  `SovereignCommunications.SCMessenger`, and iPhone/iPad device family.
- `[MISSING]` No checked-in `.entitlements`, `.xcconfig`, `ExportOptions.plist`,
  Fastlane configuration, or App Store archive/export automation was found.
- `[MISSING]` No `CODE_SIGN_ENTITLEMENTS` or Mac Catalyst setting was found.
- `[OPERATOR-GATED]` Developer-team membership, certificates, provisioning,
  bundle ownership, App Store Connect records, TestFlight groups, review
  metadata, privacy answers, legal declarations, pricing/availability, and
  release submission are not established by source alone.

### 11.2 Version and assets

- `[IMPLEMENTED]` `iOS/SCMessenger/SCMessenger/Info.plist:20-25` reports version 0.4.0,
  build 9, and minimum iOS 17.
- `[MISSING]` No inspected v0.5.0/v1.0.0 version bump or release-candidate
  archive metadata exists at HEAD.
- `[MISSING]` App icon and launch-background image content is absent as
  described in Section 7.

### 11.3 Generated/package drift

- `[MISSING]` `iOS/SCMessenger/SCMessenger/Generated/api.swift:4478` exposes
  `startSwarm(listenAddr:bootstrapAddrs:)`, while both checked-in
  `SCMessengerCore.xcframework` header copies expose only the older
  `startSwarm(listenAddr:)` signature around header line 2289.
- `[MISSING]` The generated Swift bridge contains encode/decode receipt APIs
  around `api.swift:10688-10699`; the checked-in package headers omit them.
- `[IMPLEMENTED]` The two checked-in package headers were byte-identical to one
  another; they differed from the live generated binding.
- `[IMPLEMENTED]` The app target links its direct generated binding and Rust
  static library through the build settings around
  `project.pbxproj:443-461` and `:494`. The header drift is therefore a package
  artifact defect, not proof that the current app target fails compilation.
- `[MISSING]` The inspected XCFramework directories contained headers but no
  packaged static library slices.

### 11.4 Verification script and CI

- `[MISSING]` `iOS/verify-test.sh:18-19` uses system `mktemp`, contrary to the
  repository rule that temporary files stay under repo-local `tmp/`.
- `[MISSING]` `iOS/verify-test.sh:27-34` builds the application scheme but does
  not run the XCTest suite.
- `[MISSING]` `iOS/verify-test.sh:36-42` prints warnings without failing the
  verification result.
- `[MISSING]` `.github/workflows/ios-build-test.yml:56-91` uses path filters
  that omit multiple core surfaces, including crypto/privacy and several store
  paths capable of changing the generated bridge or behavior.
- `[IMPLEMENTED]` The workflow's iOS build/test commands are at
  `.github/workflows/ios-build-test.yml:298-331`.
- `[UNPROVEN]` `.github/workflows/ios-build-test.yml:322` explicitly waives a
  simulator hardware limitation; it is not physical transport proof.
- `[IMPLEMENTED]` The workflow's macOS job at
  `.github/workflows/ios-build-test.yml:378-415` builds Rust/CLI surfaces, not a
  macOS application.
- `[MISSING]` No UI-test job, accessibility job, physical-device farm job,
  archive/export job, TestFlight upload job, or notarized macOS application job
  was found.

## 12. Test and device evidence

### 12.1 Unit-test inventory

- `[IMPLEMENTED]` Exhaustive search found 53 Swift `func test...` declarations
  across five checked-in test files.
- `[UNPROVEN]` `HANDOFF/gpt/GPT_IOS_LANE_COMPLETION_2026-07-28.md:46-59`
  records 47/47 simulator tests for an older candidate. It is historical, not
  a run against this HEAD.
- `[UNPROVEN]` The branch-only `HANDOFF/CAO_STATE.md:74-80` records 53/53 tests
  for its candidate. That record is not on main and was not rerun here.
- `[MISSING]` `iOS/SCMessengerTests/NotificationVerificationTests.swift:40-46`
  includes a tautological assertion.
- `[MISSING]` The same file at `:115-119` computes whether notifications are
  present but does not assert that result.
- `[MISSING]` Several simulated processor tests at
  `iOS/SCMessengerTests/NotificationVerificationTests.swift:408-438` complete
  without behavioral assertions.
- `[MISSING]` `iOS/SCMessengerTests/MeshBackgroundServiceTests.swift:20-27`
  injects a no-op and `:60-69` exercises only a debug simulation.
- `[MISSING]` No current test was found for request rejection/block deletion,
  visible status, manual retry, external deep link, inbound share, Apple BLE
  resource bounds, L2CAP wiring, Multipeer identity refresh, App Store archive,
  or real background scheduling.

### 12.2 Historical physical Apple evidence

- `[UNPROVEN]` `HANDOFF/gpt/IOS_MACOS_PR139_STATUS_2026-08-09.md:19-30`
  records a device build, signing, and installation. Launch/runtime was blocked
  because the device was locked. This supersedes an older 2026-08-07 account
  failure as the latest inspected signing record, but it still does not prove
  app runtime.
- `[UNPROVEN]` The same document at `:6-17` records that the macOS CLI built and
  launched with zero peers. It does not record delivered traffic.
- `[HARDWARE-GATED]` No current-candidate physical iPhone launch, two-iPhone
  transfer, iPhone-to-Android transfer, iPhone-to-Windows transfer,
  iPhone-to-macOS transfer, background custody, notification action, receipt,
  or Bluetooth restoration result was found.

## 13. Native macOS gap inventory

- `[MISSING]` The Xcode project has no macOS or Mac Catalyst application target.
- `[MISSING]` No SwiftUI macOS application source, macOS entitlements, signing,
  sandbox, hardened-runtime, notarization, or distribution configuration was
  found.
- `[IMPLEMENTED]` `shared/build.gradle.kts:9-30` defines a JVM desktop target,
  not a native macOS target.
- `[MISSING]` `shared/src/desktopMain/kotlin/com/scmessenger/shared/Main.kt:3-6` is a console print,
  not a user application; `shared/src/desktopMain/kotlin/com/scmessenger/shared/Platform.kt:3`
  identifies the target as Linux.
- `[MISSING]` `desktop_bridge/src/desktop_bridge.rs:250-280` uses non-Linux BLE
  stubs; `desktop_bridge/src/notification.rs:1-50` reports non-Linux
  notifications as unsupported.
- `[MISSING]` `cli/src/ble_mesh.rs:695-743` can observe macOS advertisements but
  disables GATT central behavior; peripheral behavior is unimplemented at
  `cli/src/ble_mesh.rs:830-855`.
- `[UNPROVEN]` Historical evidence shows macOS CLI build/launch only, with no
  delivered-message result.
- `[SCOPE-AMBIGUOUS]` The canonical v1 desktop plan is Linux/WSL-oriented and
  does not select a native macOS GUI stack. The user's request to work through
  OSX v1.0.0 therefore crosses an unresolved product-scope and tech-stack
  boundary governed by AGENTS rule 9. Source evidence does not authorize this
  scanner to choose SwiftUI, Catalyst, KMP/JVM packaging, or CLI-only scope.

## 14. Android parity and Windows/core deficiencies for bilateral review

These are current-source findings the Apple lane must not lose when comparing
itself to Android. They are not a declaration that the Apple lane owns the
fixes.

### 14.1 Android behavior ahead of iOS

- `[IMPLEMENTED]` Android has a reachable blocked-peers route/screen at
  `android/app/src/main/java/com/scmessenger/android/ui/MeshApp.kt:341-342` and
  `:385-394`; iOS has block APIs but no reachable management UI.
- `[IMPLEMENTED]` Android's request inbox offers accept, reject, and
  block-and-delete actions at
  `android/app/src/main/java/com/scmessenger/android/ui/screens/RequestsInboxScreen.kt:70-205`;
  iOS currently offers Accept only.
- `[IMPLEMENTED]` Android exposes APK sharing from Settings at
  `android/app/src/main/java/com/scmessenger/android/ui/screens/SettingsScreen.kt:255`
  and `:449-451`, including system send/QR-host paths. Android also has an
  inbound-share receiver. iOS lacks the equivalent extension/flow and has an
  Apple distribution decision instead of raw APK equivalence.

### 14.2 Android deficiencies relevant to parity

- `[MISSING]` Android's live chat route invokes its local zero-status bubble at
  `android/app/src/main/java/com/scmessenger/android/ui/screens/ChatScreen.kt:275-279`;
  that live bubble is defined at `:450-483` and does not render delivery state.
- `[MISSING]` The separate status-aware
  `android/app/src/main/java/com/scmessenger/android/ui/chat/MessageBubble.kt:19-165`
  had no caller outside its declaration in the exhaustive search. It is dead,
  so Android cannot be used as evidence that status presentation ships.
- `[MISSING]` Android ChatViewModel's Failed branch only logs at
  `android/app/src/main/java/com/scmessenger/android/ui/viewmodels/ChatViewModel.kt:261-263`.
  Retry helpers at `:357-399` had no live UI callers. Android therefore also
  lacks the requested visible failed/manual-retry experience.
- `[MISSING]` Android's request data path invokes
  `ironCore.drainReceivedMessages()` on load at
  `android/app/src/main/java/com/scmessenger/android/data/MeshRepository.kt:4315-4353`.
  This is destructive retrieval, not a non-destructive request-inbox read.
- `[MISSING]` `RequestsInboxScreen.kt:109-116` explicitly does not use its
  `onNavigateToChat` callback; accepting a request does not navigate to chat.

### 14.3 Shared finite-abandonment defect

- `[WINDOWS/CORE-OWNED]` Android's current finite boundary is defined around
  `android/app/src/main/java/com/scmessenger/android/data/MeshRepository.kt:695-697`,
  applied at `:824-826`, and enforced at `:7040-7119`.
- `[WINDOWS/CORE-OWNED]` Core's finite outbox boundary is defined at
  `core/src/store/outbox.rs:65-66` and enforced at `:538-570`; custody expiration is
  present at `:745-751`.
- `[IMPLEMENTED]` iOS mirrors a 12-attempt/seven-day boundary and can remove
  unconfirmed aged entries as described in Section 4.3.
- `[WINDOWS/CORE-OWNED]`
  `HANDOFF/todo/P0_ANDROID_FINITE_RETRY_ABANDONMENT_2026-08-10.md:1-90`
  records the active cross-platform defect. A durable contract correction must
  be core/Windows-owned and reconciled into both mobile adapters.

### 14.4 Shared contact-recovery defect

- `[WINDOWS/CORE-OWNED]` `core/src/contacts_bridge.rs:294-303` and `:387-397`
  use PeerID bytes as a public-key placeholder during recovery.
- `[MISSING]` Android has an additional fallback path around
  `android/app/src/main/java/com/scmessenger/android/data/MeshRepository.kt:9881-9929`,
  including the peer-ID fallback at `:9901-9906`.
- `[WINDOWS/CORE-OWNED]`
  `HANDOFF/todo/P1_CONTACT_RECOVERY_WRITES_PEERID_AS_PUBLIC_KEY_2026-08-10.md:1-95`
  records the active defect. Apple parity claims must not treat recovered
  identity state as proven while this shared contract remains open.

### 14.5 Current cross-platform proof gap

- `[HARDWARE-GATED]` Latest merged CTO state still records the D6/D7 hardware
  messaging rerun as pending at `upstream/main` `8663a149...`,
  `HANDOFF/CTO_STATE.md:76-86`; the unmerged four-node kickoff proposes a new
  combined gate but has not yet frozen it.
- `[HARDWARE-GATED]` The clean five-node gate did not run, and the explicit
  four-node Apple/Windows request has no durable closure record; see Section 15.
- `[WINDOWS/CORE-OWNED]` Windows is the authoritative environment for Rust,
  Android, CLI, and shared-core gates. Apple `xcodebuild` authority cannot
  substitute for those results.

### 14.6 Stale Android packets that should not drive Apple work uncorrected

- `[STALE-DOC]` A deep-link ticket premise that Android join links are unwired
  is contradicted by current
  `android/app/src/main/java/com/scmessenger/android/ui/viewmodels/MainViewModel.kt:369-386`,
  which confirms and dials after explicit user approval, and
  `android/app/src/main/java/com/scmessenger/android/ui/MeshApp.kt:238-280` and
  `:397-403`, which route/register the flow.
- `[STALE-DOC]` A self-ratchet/mDNS premise is contradicted by the current
  service-lost self guard at
  `android/app/src/main/java/com/scmessenger/android/transport/MdnsServiceDiscovery.kt:202-216`.
- `[STALE-DOC]` A routing-engine premise that `peer_seen` is not wired is
  contradicted by `core/src/transport/swarm.rs:4870-4890`.

## 15. CAO/CTO coordination and four-node response audit

### 15.1 Ref topology observed

The closing provenance sweep enumerated 191 local/remote refs and searched tracked HANDOFF content,
full file history, ref trees, and exact-filename references without accepting a
pagination cap as the total.

No single reviewed branch contained all current CAO, CTO, Windows-response,
and PR139-exit records.

| Ref/candidate | CAO state | CAO adoption packet | CTO state and Windows responses | PR139 Mac-exit packet |
|---|---|---|---|---|
| `HEAD` / `upstream/main` at `5f052764...` | absent | absent | present | absent |
| `origin/gpt/ios-macos-launch-debug-20260810` at `c1b457...` | present | present | absent | absent |
| `upstream/gpt/ios-macos-launch-debug-20260810` at `0200c61...` | present | absent | absent | absent |
| dedicated PR139 exit branch | absent | absent | absent | present |
| `upstream/main` at `8663a149...` | absent | absent | present/latest merged CTO state | absent |
| `upstream/cto/four-node-parity-kickoff-2026-08-21` at `3289fa5d...` | absent | absent | present plus branch-only four-node response | absent |

The two Apple branch tips have merge-base `0200c61...`; `git rev-list
--left-right --count origin/gpt/ios-macos-launch-debug-20260810...upstream/gpt/ios-macos-launch-debug-20260810`
returned `1 0`.

### 15.2 CAO-originated records not on current main

1. `HANDOFF/CAO_STATE.md`

   - Added by commit
     `e314fd219880da61394df815710e84490d4cb6ff`.
   - Found only on the inspected Apple launch/debug refs, not on HEAD/main.
   - In-flight state is at lines 23-32, critical-path findings at lines 43-60,
     open operator/device/package blockers at lines 133-150, and
     source/artifact/runtime evidence distinctions at lines 151-164.
   - Its branch-only status comes from the ref-tree comparison in Section 15.1;
     it is not present on the reviewed main candidates.

2. `HANDOFF/gpt/GPT_MAC_CAO_TOKEN_CURB_PARITY_ADOPTION_2026-08-15.md`

   - Added by commit
     `c1b457bbb1cecf0aeb63fb4965a5620a0e8415ac`.
   - Found on the origin Apple branch, not on upstream main and not on the
     upstream Apple tip inspected here.
   - Ownership is at lines 14-18, static findings at lines 46-87, parity
     findings at lines 193-228, work packages at lines 229-304, and operator
     decisions at lines 325-338.
   - Requested cross-lane matters include macOS BLE scope and Apple team/signing
     decisions.

3. `HANDOFF/gpt/PR139_MAC_EXIT_WINDOWS_TAKEOVER_2026-08-12.md`

   - Added by commit
     `c81518c26c93b227d79e9d2ed2e8d15b36a4eb18`.
   - Found on a dedicated origin/upstream branch, not on main and not on the
     Apple launch/debug branch.
   - Ownership is at lines 9-25; the preserved four-lane evidence and official
     0/12 result are at lines 64-75; five node rows/12 flows are at lines
     157-182; gates/soak at lines 184-197; the Windows checklist is at lines
     216-224.
   - W5 requests a Mac two-row result packet.

### 15.3 CTO/Windows response records on current main

1. `HANDOFF/CTO_STATE.md`

   - Current main record at HEAD.
   - Current blocker/evidence lines are cited in Sections 3 and 14.
   - A newer version entered `upstream/main` through PR #201 at merge commit
     `8663a149ce3e9110e4bb0a6d24682a8f8faff7ed`; its content commit is
     `67d3969cf997d51306a7e042d28f1c2984c23a49`.
   - Its lines 76-86 retain D6/D7, tag, then queue sequencing. The separate
     four-node response was added afterward on an unmerged one-commit branch.

2. `HANDOFF/WINDOWS_NODE_PARITY_AND_GATE_READINESS_2026-08-12.md`

   - Added by commit
     `b391933d6acfe337e0b6f6ab7e48f0f6d73e28a8`.
   - Present on current main.
   - Lines 3-6 state authority, lines 12-22 record iOS/macOS offline/provenance
     state, and lines 123-145 record fleet/dispatch readiness.

3. `HANDOFF/PR139_FIVE_NODE_GATE_STATUS_2026-08-13.md`

   - Added by the same commit
     `b391933d6acfe337e0b6f6ab7e48f0f6d73e28a8`.
   - Present on current main.
   - Lines 1-5 state authority, lines 44-52 record Mac/iOS offline status,
     lines 90-97 record the five-node status, and lines 123-131 give the
     remaining checklist.

These are Windows/CTO coordination records, but neither explicitly names the
four-node request below as acknowledged, superseded, or closed.

### 15.4 Current CTO four-node response at commit `3289fa5d...`

A current, explicit CTO-to-CAO four-node response was found during the closing
ref sweep:

- Path:
  `HANDOFF/gpt/WINDOWS_V040_V050_FOUR_NODE_PARITY_KICKOFF_2026-08-21.md`.
- Commit: `3289fa5d15eb6b4e631e5830e477030886799e54`.
- Ref: `upstream/cto/four-node-parity-kickoff-2026-08-21`.
- Parent: merged-main candidate
  `8663a149ce3e9110e4bb0a6d24682a8f8faff7ed`.
- Relation to that main candidate: `0 1` from
  `git rev-list --left-right --count 8663a149...3289fa5d...`.
- Commit time: `2026-08-20T20:15:21-10:00`.
- Status inside the packet: Active.
- From/To: Windows CTO seat to Mac lane/CAO at lines 5-7.
- It explicitly extends `MAC_WINDOWS_BLE_PARITY_QUEUE_2026-08-11.md` at line 7.

The packet records the current operator directive at lines 9-21: coordinate the
v0.5 parity branch; use Windows, Android, macOS, and iOS while excluding the
AWS node from this run; require all four nodes to see the other three; and use
the gate to discharge D4/D6/D7 without changing their criteria. Lines 18-21
record a parity-workstream exception to `SHIP_PLAN.md`'s iOS hold. This is a
branch-only record, not content present in the checked-out HEAD or merged main.

Requested Apple actions are explicit at lines 46-61:

1. Acknowledge the packet through both a tracked `HANDOFF/gpt/` response and a
   comment on the CTO PR.
2. Reconcile `gpt/v050-ios-release-ready` with current main, resolve the merged
   #139/#180/#183 world, open a PR, and run the authoritative Mac
   `xcodebuild` gate. The packet calls this a rebase; AGENTS rule 12 still makes
   any actual rebase operator-approval-gated.
3. Bring up the macOS node at the eventual freeze SHA and report listening
   multiaddresses plus self-reported git hash.
4. Build/install iOS at that same freeze SHA and produce receiver-side decrypt,
   durable history, and receipt evidence rather than sender/transport/UI proxy
   evidence.
5. Continue bilateral monitoring; the Windows seat commits to a 20-minute watch
   of `HANDOFF/gpt/` and `gpt/*` tips.

The proposed four-node contract is at lines 63-88:

- Pass 0: the same freeze SHA on all four nodes.
- Pass 1: all 12 directed visibility edges, with connection evidence at both
  ends.
- Pass 2: bidirectional delivery truth, receipt round trip, restart stability,
  and queued delivery after reconnect.
- Pass 3: D6 transport racing and D7 offline proximity in the same run.
- Pass 4: the parity feature matrix with unsupported cells recorded honestly;
  the packet explicitly identifies current macOS BLE scan as simulated.
- The freeze SHA remains unset until the Windows CI artifact job lands and the
  v0.5 rebase PR is green.

The packet's lines 90-95 also disclose Windows-side work including a rule-8
review-pending transport change. Lines 97-103 preserve bilateral acknowledgment
and independent validation requirements. Those requirements do not waive the
approval/security gates in Section 17.

Related Windows source movement was also observed at
`upstream/cto/windows-cli-artifact-2026-08-21`, commit
`9279f97dc2f691543bd6c66075aded14a417b65e`. That branch adds a Windows CLI
release-binary/provenance artifact job to `.github/workflows/ci.yml`; it is
source for the prerequisite named in the packet, not evidence that a freeze-SHA
binary artifact has already been produced.

Closing-state ambiguities:

- `[UNPROVEN]` The kickoff commit is not on merged main.
- `[UNPROVEN]` Exhaustive reference search across the 191 observed refs found no
  tracked CAO acknowledgment naming this new kickoff file or commit.
- `[UNPROVEN]` The draft contract says it freezes on CAO acknowledgment; no
  freeze SHA is recorded.
- `[SCOPE-AMBIGUOUS]` The new packet does not name the older 2026-08-08 log-pull
  request as `SUPERSEDES` or `CLOSES`. It is a current four-node answer to the
  operator/CAO workstream, but it does not make the older request's record chain
  unambiguous.

### 15.5 Earlier explicit four-node request and its still-unnamed disposition

The exact active request is:

- `HANDOFF/gpt/GPT_MAC_IOS_LOG_PULL_REQUEST_2026-08-08.md`
- Added by commit `8646a2ca366efe1e96d3fbdd2f749b36c1932e5e`.
- Present on current main and the inspected relevant refs.
- Lines 39-65 request iOS logs/build information and questions.
- Lines 66-84 request macOS CLI state.
- Lines 86-91 request an Android+iOS+macOS+Windows same-subnet rerun with
  retained log buffers and a BLE-only leg.
- The packet's status is Active.

`HANDOFF/ORCHESTRATOR_TAKEOVER_2026-08-08.md:268-273` says that request had not
yet been sent at that checkpoint.

Full-history pickaxe for the exact request filename found only its introduction
commit `8646a2ca...`. A tracked-content search across the reviewed current refs
found the request itself and the takeover reference, but no response/acknowledge/
closure record naming that request. The later five-node status files do not
explicitly say that they supersede it.

Therefore, after incorporating the current CTO response:

- `[IMPLEMENTED]` A durable branch-only current CTO-to-CAO four-node response
  exists at commit `3289fa5d...` and is fully described in Section 15.4.
- `[UNPROVEN]` No durable tracked response was found that explicitly names the
  exact older `GPT_MAC_IOS_LOG_PULL_REQUEST_2026-08-08.md` record as
  acknowledged, superseded, or closed.
- `[SCOPE-AMBIGUOUS]` It is unclear whether the request remains open, was
  superseded by the new four-node kickoff, was informally superseded by the
  later five-node plan, or was subsumed by an earlier D4/D6/D7 sequence.
- `[HARDWARE-GATED]` None of those interpretations creates four-node runtime
  evidence. The official preserved result in the PR139 exit packet was 0/12.

### 15.6 BLE bilateral packet and acknowledgment ambiguity

- `HANDOFF/gpt/MAC_WINDOWS_BLE_PARITY_QUEUE_2026-08-11.md` is present on main
  and entered history through commits in the `a29...`/`c93...` sequence.
- Lines 6-24 enumerate gaps; lines 28-62 allocate lane actions; lines 64-83
  define the receiver matrix; lines 85-93 require a Windows acknowledgment by
  message and PR comment plus reciprocal validation.
- No tracked acknowledgment naming that exact file was found.
- `HANDOFF/gpt/WINDOWS_PR139_RESUME_STATE_2026-08-11B.md:99-106` records
  `GPT-MAC CONCURRED` and an accepted objection in a branch contract; lines
  141-148 say to read the PR reply and do not declare the gate complete.
- `[SCOPE-AMBIGUOUS]` This is evidence of coordination, but it is not an
  unambiguous, durable file-specific acknowledgment/closure of the BLE queue.

## 16. Merge-watch requirements so coordination is not lost

The branch topology above demonstrates a concrete failure mode: a merge can
retain implementation while silently omitting the CAO record, CTO response, or
the packet that explains an unresolved hardware gate. The following fields are
the minimum evidence needed to make a bilateral request and its response
reconstructable from tracked history:

| Field | Evidence purpose |
|---|---|
| `RECORD_ID` | Stable identifier shared by request, response, and closure. |
| `STATUS` | `OPEN`, `ACKNOWLEDGED`, `BLOCKED`, `DEFERRED`, `SUPERSEDED`, or `CLOSED`. |
| `TOPIC` | Exact bilateral subject. |
| `REQUESTER_ROLE` / `RESPONDER_ROLE` | Durable CAO/CTO ownership. |
| `REQUESTER_REF` / `RESPONDER_REF` | Branch/ref on which each record was read. |
| `REQUESTER_COMMIT` / `RESPONDER_COMMIT` | Exact candidate ancestry. |
| `REQUEST_PATH` / `RESPONSE_PATH` | Tracked record location. |
| `REQUEST_LINES` / `RESPONSE_LINES` | Exact relevant evidence range. |
| `SOURCE_HEAD` / `TARGET_HEAD` | Candidate relation at handoff time. |
| `PLATFORM_OWNERS` | iOS, macOS, Android, Windows, CLI, cloud node, core. |
| `REQUESTED_ACTIONS` | Complete action list, without truncation. |
| `ACKNOWLEDGED_ACTIONS` | Actions explicitly accepted by the responder. |
| `DECLINED_ACTIONS` | Actions explicitly rejected, with reason/ref. |
| `DEFERRED_ACTIONS` | Actions moved to a named milestone/ref. |
| `SUPERSEDES` / `SUPERSEDED_BY` | Explicit replacement relation. |
| `MERGE_DESTINATION` / `MERGED_AS` | Destination and resulting commit. |
| `PR` | Durable PR URL/number when used. |
| `RUNTIME` / `ARTIFACT` / `DEVICE` | Exact evidence environment and candidate. |
| `EVIDENCE_CLASS` | Source, artifact, simulator, device, multi-node, distribution. |
| `GATE_RESULT` | Pass/fail/blocked plus exact command or flow matrix. |
| `OPEN_AMBIGUITIES` | Questions that remain fail-closed. |
| `NEXT_OWNER` | Named role responsible for the next durable response. |
| `LAST_REDERIVED_AT` | Time the record was checked against current refs. |

For every merge carrying Apple/Windows coordination evidence:

1. Enumerate all named coordination paths on both base and head with
   `git ls-tree`; do not use a limited API result.
2. Diff the full path set and full contents. Every omitted request/response
   must have a tracked `SUPERSEDED_BY` record; silence is not closure.
3. After integration, verify each expected path with `git ls-tree`, trace its
   provenance with `git log --follow`, and verify the response/approval commits
   are ancestors of the integrated candidate.
4. Record PR comments, chat messages, or ephemeral acknowledgments by durable
   URL/identifier and candidate in a tracked response. An instruction to
   “read the PR reply” is not independently merge-safe.
5. Keep unresolved requests `OPEN` and fail closed. A later plan with a similar
   device matrix is not an implicit response unless it names the prior record
   or records `SUPERSEDES`.
6. Reconcile these exact paths before treating the Apple/Windows state as
   whole-repository communication:

   - `HANDOFF/CAO_STATE.md`
   - `HANDOFF/CTO_STATE.md`
   - `HANDOFF/gpt/GPT_MAC_CAO_TOKEN_CURB_PARITY_ADOPTION_2026-08-15.md`
   - `HANDOFF/gpt/PR139_MAC_EXIT_WINDOWS_TAKEOVER_2026-08-12.md`
   - `HANDOFF/gpt/GPT_MAC_IOS_LOG_PULL_REQUEST_2026-08-08.md`
   - `HANDOFF/gpt/WINDOWS_V040_V050_FOUR_NODE_PARITY_KICKOFF_2026-08-21.md`
   - `HANDOFF/gpt/MAC_WINDOWS_BLE_PARITY_QUEUE_2026-08-11.md`
   - `HANDOFF/WINDOWS_NODE_PARITY_AND_GATE_READINESS_2026-08-12.md`
   - `HANDOFF/PR139_FIVE_NODE_GATE_STATUS_2026-08-13.md`
   - `HANDOFF/gpt/WINDOWS_PR139_RESUME_STATE_2026-08-11B.md`

## 17. Mandatory bilateral approval record for Rust/core dependencies

Any Apple request that changes Rust/core behavior needs a durable approval
record containing all of these fields:

| Field | Required evidence |
|---|---|
| `CORE_PATHS` | Complete changed path list, without truncation. |
| `CAO_APPROVAL` | `APPROVE` or `BLOCK`, exact CAO record path/ref/commit/candidate. |
| `CTO_APPROVAL` | `APPROVE` or `BLOCK`, exact CTO record path/ref/commit/candidate. |
| `OPERATOR_APPROVAL` | Required when AGENTS rule 9 applies; exact durable decision. |
| `ADVERSARIAL_REVIEW` | Exact independent review artifact, candidate hash, scope, and verdict for protected core paths. |
| `WINDOWS_GATE` | Exact authoritative Windows commands, candidate, environment, and results. |
| `IOS_XCODE_GATE` | Exact authoritative Mac `xcodebuild` commands, candidate, destination, and results when Apple bindings/app are affected. |

`CAO_APPROVAL` and `CTO_APPROVAL` are additive coordination evidence. They do
not waive or replace:

- AGENTS rule 8 independent adversarial review for
  `core/src/{crypto,transport,routing,privacy}/`;
- AGENTS rule 9 operator escalation for architecture, security/privacy
  tradeoffs, stack changes, API contract breaks, or release timing/versioning;
- the Windows host's authoritative Rust/Android/shared-core build gates;
- the Mac lane's authoritative `xcodebuild` gate;
- physical hardware/farm evidence where the acceptance criterion is a runtime
  flow rather than compilation;
- normal PR, merge, documentation-sync, and release governance.

No bilateral approval record satisfying this schema was found for the currently
open finite-abandonment/contact-recovery work in the inspected Apple/CTO branch
set. That absence does not block source inspection; it does block representing
the cross-lane dependency as jointly approved.

## 18. Source-packet readiness reconciliation

This scanner does not hold controller/dispatch authority. The evidence supports
the following fail-closed packet classification for the controller:

| Packet/work package | Evidence class | Dispatch reconciliation |
|---|---|---|
| `IOS-V050-1` (`tmp/tasks/IOS-V050-1.dispatch.md`) | `[ACTIVE-UNINTEGRATED]` | Already dispatched with integration `NOT_STARTED` and review `OUTSTANDING`; a second writer would overlap the same request/status/outbox files. |
| V050-I0 in `HANDOFF/gpt/GPT_PLANNING_040_050_VERDICT.md:205` | `[UNPROVEN]` | Current test sources no longer show the two stale API/type defects described at lines 192-193 and 53 test declarations exist, but no current-candidate `xcodebuild test`/`.xcresult` was produced by this audit. The remaining need is authoritative evidence, not a blind restoration dispatch. |
| V050-I1 at `GPT_PLANNING_040_050_VERDICT.md:206` | `[MISSING]` / `[WINDOWS/CORE-OWNED]` | Checked-in package headers drift from generated Swift; Apple regeneration/build work is coupled to the Windows FFI gate and candidate provenance. It is not an Apple-only independent completion claim. |
| V050-I2 at `GPT_PLANNING_040_050_VERDICT.md:207` | `[ACTIVE-UNINTEGRATED]` | Apple-source work is eligible only after deconflicting the already-running `IOS-V050-1`, which edits the same outbox/status surfaces. |
| V050-I3 at `GPT_PLANNING_040_050_VERDICT.md:208` | `[IMPLEMENTED]` | Current UI exposes only BLE and Internet/Swarm and applies both to live services. The packet's stated WiFi Aware/Direct source premise no longer exists at the audited HEAD. |
| V050-I4 at `GPT_PLANNING_040_050_VERDICT.md:209` | `[WINDOWS/CORE-OWNED]` | The receipt state-machine contract crosses core, FFI, Android, and iOS. It requires the bilateral and protected-core governance in Section 17 before shared-contract implementation can be represented as approved. |
| V050-I5 at `GPT_PLANNING_040_050_VERDICT.md:210` | `[HARDWARE-GATED]` | Physical matrix only; simulator/source work cannot discharge it. |
| `WINDOWS_V040_V050_FOUR_NODE_PARITY_KICKOFF_2026-08-21.md` | `[UNPROVEN]` / `[HARDWARE-GATED]` | Active CTO response exists at `3289fa5d...`, but CAO acknowledgment, freeze SHA, Apple branch reconciliation, authoritative builds, installs, and the device matrix remain open. |
| `APP_SHARING_IOS_PARITY_CROSS_INSTALL_2026-08-05.md` | `[OPERATOR-GATED]` | TestFlight versus Ad Hoc/product-distribution decision is unresolved; this is not a source-only dispatch. |
| Native macOS GUI/product work | `[SCOPE-AMBIGUOUS]` / `[OPERATOR-GATED]` | No settled v1 product target or stack exists. An implementation dispatch would choose architecture beyond the read authority. |

On the inspected evidence, the only Apple source packet already cleared into
active work is `IOS-V050-1`, and it is already occupied. Additional immediate
Apple implementation dispatch cannot be inferred safely from filenames alone:
I3 is already wired, I1/I4 cross Windows/core gates, I5 and the four-node run
are hardware-gated, app distribution is operator-gated, and native macOS scope
is unsettled. This classification does not decide what a controller may
dispatch after re-deriving the candidate and canonical queue; it records only
what this audit itself can prove.

## 19. Evidence required to close the Apple v1 inventory

This table states what evidence is absent; it does not authorize sequencing or
implementation outside the canonical plan.

| Area | Current class | Closure evidence absent from this audit |
|---|---|---|
| iOS request reject/block | `[ACTIVE-UNINTEGRATED]` | Integrated reviewed candidate plus reachable UI/repository tests and device behavior. |
| Delivery state/manual retry | `[ACTIVE-UNINTEGRATED]` / `[MISSING]` | Reachable presentation, durable outbox semantics, tests, and cross-platform receipt/device result. |
| Blocked-identities management | `[MISSING]` | Reachable iOS screen, filtering semantics, unblock path, and tests. |
| External deep links | `[MISSING]` | Entitlement/configuration, explicit confirmation path, parsing/security tests, and device invocation. |
| Inbound share | `[MISSING]` | Extension/app-group target, sanitization/limits, app handoff, and device proof. |
| Remote notifications | `[MISSING]` / `[OPERATOR-GATED]` | APNs configuration, token/backend contract if in scope, privacy behavior, terminated-app device evidence. |
| Background work | `[UNPROVEN]` / `[HARDWARE-GATED]` | Physical scheduler, restoration, suspension/termination, custody, and notification-action evidence. |
| BLE | `[MISSING]` / `[HARDWARE-GATED]` | Resource/integrity bounds, reachable L2CAP if in scope, and cross-platform physical flows. |
| Multipeer | `[UNPROVEN]` / `[SCOPE-AMBIGUOUS]` | Scope disposition, stable identity behavior, two-device and Meeting Mode evidence. |
| mDNS/ledger discovery | `[IMPLEMENTED]` / `[HARDWARE-GATED]` | Actual-bound-port and multi-node device evidence under current candidate. |
| Accessibility | `[MISSING]` | Explicit semantics plus VoiceOver/Dynamic Type/contrast/focus/device evidence. |
| Localization | `[MISSING]` / `[SCOPE-AMBIGUOUS]` | Operator-set scope and localized-resource/test evidence if v1-gated. |
| App icon/launch assets | `[MISSING]` | Complete asset catalog rendered on devices/archive. |
| Signing/archive/TestFlight | `[OPERATOR-GATED]` | Current-candidate archive/export/upload/install/release evidence. |
| iOS CI | `[MISSING]` | Complete path triggers, XCTest enforcement, no silent warning success, archive/device scope as settled. |
| macOS application | `[MISSING]` / `[SCOPE-AMBIGUOUS]` | Operator-selected product/stack plus target, platform services, signing/notarization, tests, and runtime. |
| Four-node request | `[UNPROVEN]` / `[HARDWARE-GATED]` | Integrated tracked presence or explicit supersession of CTO commit `3289fa5d...`, durable CAO acknowledgment, frozen SHA, relation to the older request, and named matrix result. |
| Five-node/farm drill | `[HARDWARE-GATED]` | Required node rows/flows, logs, soak, receipt/custody results, and candidate provenance. |
| Core finite abandonment | `[WINDOWS/CORE-OWNED]` | Bilateral approvals, governance reviews, Windows gates, Apple adapter/xcode gate, hardware proof. |
| Contact recovery | `[WINDOWS/CORE-OWNED]` | Bilateral approvals, shared identity-contract evidence, Windows gates, adapter tests, device proof. |
| Privacy controls | `[SCOPE-AMBIGUOUS]` / `[WINDOWS/CORE-OWNED]` | v1/v1.1 scope disposition, honest UI/runtime parity, adversarial review for protected core changes. |

## 20. Search and provenance command ledger

The factual inventory above was derived from commands run in this session,
including:

- `git status --short --branch` and targeted `git diff --ignore-cr-at-eol`
  checks to separate existing working-tree line-ending changes from live source.
- `git rev-parse HEAD upstream/main origin/gpt/v050-parity-burndown` and
  `git show -s --format=...` for candidate identity.
- `rg --files` across `iOS`, `android`, `core`, `shared`, `desktop_bridge`,
  `cli`, `.github`, `HANDOFF`, and orchestration state.
- Full `rg -n` call-site/configuration searches for navigation, requests,
  block/unblock, delivery states, retry, notifications, deep links, share
  extensions, accessibility, localization, background modes, mDNS, BLE,
  L2CAP, Multipeer, privacy controls, tests, signing, targets, and packaging.
- Targeted `nl -ba ... | sed -n ...` reads of every line range cited in this
  artifact. These were context reads, not enumerations treated as exhaustive.
- `git for-each-ref` across all 191 refs observed in the closing sweep.
- `git ls-tree -r --name-only <ref>` for the exact CAO/CTO/request/response
  paths on each relevant branch.
- `git log --all --full-history -- <path>`, `git log --all -S<filename>`,
  `git branch -a --contains <commit>`, and `git merge-base` for provenance.
- `git grep` across reviewed refs for exact four-node and bilateral packet
  references.
- `git rev-list --left-right --count` for the two Apple branch tips.
- `find`/`rg --files` inventory of Xcode targets, entitlements, configuration,
  asset catalog content, extensions, tests, and package contents.
- `git check-ignore -v tmp/orchestration/evidence/APPLE-V1-AUDIT.md`, which
  showed `.gitignore:94:tmp/` covers this evidence artifact.

## 21. Limits and fail-closed conclusions

- This is a source/history audit, not a build or validation verdict.
- Historical simulator/device statements apply only to the candidate named by
  their source and were not projected onto HEAD.
- No source presence was treated as runtime proof without a reachable caller.
- No later plan was treated as an implicit acknowledgment of an earlier
  bilateral packet.
- No API result cap was accepted as a complete branch/history enumeration.
- Native macOS GUI scope, v1/v1.1 privacy/Multipeer scope, iOS distribution
  mode, CAO acknowledgment/freeze of the current four-node response, and the
  older four-node request's explicit disposition remain unresolved by the read
  evidence.
- The Apple v1 state is therefore not ready to be represented as perfectly
  complete. It has a strong implemented base, but still contains missing,
  unintegrated, operator-gated, hardware-gated, Windows/core-owned, and
  scope-ambiguous work as classified above.
