# Apple v1.0.0 execution program — complete continuity snapshot

Status: Snapshot; source evidence only; no release-readiness claim
Last updated: 2026-08-21 HST
Source path: `tmp/orchestration/plans/APPLE-V1-PROGRAM.md`
Source SHA-256: `12a7bac55dc6b929e53093e8bf4d24e2bfeeb7421291db11286dc1dd59d636a6`
Redaction declaration: Every occurrence of the recorded local repository prefix is deterministically replaced with `<REPO_ROOT>`; source body 1551 lines, redactions 0. The body below is otherwise byte-for-byte complete.

# Apple v1.0.0 execution program

Status: Operator-authorized for isolated Apple work-ahead branches/PRs;
mainline integration and release remain gated
Date: 2026-08-21 HST
Planner baseline: `5f052764a713a5932b1d99d51bf6c41e8143c477`
Observed branch: `gpt/v050-parity-burndown`
Scope: Apple-owned iOS and macOS work from the current v0.5 parity cut through
the Apple portions of v1.0.0. No core/Rust implementation is authorized here.

## 1. Direction and unresolved authority

The fastest safe route is a chain of short, reviewed `gpt/*` pull requests, not
one Apple v1 integration branch. Every source packet below owns a disjoint path
set while it runs, has a Mac-authoritative Xcode gate where applicable, and is
small enough to review and either merge or close in less than 48 hours.

The operator's explicit instruction in this task authorizes Apple source work
ahead through v1.0.0 and upload to isolated `gpt/*` branches and pull requests.
Record `APPLE-GOV-0: SATISFIED-BRANCH-WORK-ONLY` in controller state. This is a
scoped exception to the Apple/v1 no-work wording in `SHIP_PLAN.md`; it is not a
mainline-freeze override. It does not authorize merging any PR into main,
changing release timing/version/tags, moving HANDOFF queue tickets, modifying
core/Rust, or bypassing security, review, hardware, account, legal, or release
gates. Those remain Windows-orchestrator/operator decisions.

The same instruction authorizes retaining these bounded work-ahead `gpt/*` PR
branches while the mainline freeze prevents integration. Each branch still
contains one packet, reports its frozen base, and is reviewed promptly. The
controller must not create a long-lived `gpt/apple-v1` integration branch or
use work-ahead retention for unrelated scope. When integration becomes legal,
the Windows orchestrator revalidates each PR against current main and either
merges it or requests a fresh forward-applied branch; no rebase/force-push is
implied.

The architecture boundary is fixed:

- Every iPhone, Android device, CLI process, cloud deployment, and desktop app
  is a node; each node performs store-and-forward custody. No standalone
  forwarding role or anonymous forwarder may be introduced.
- The Apple lane may change native Swift, Xcode project/configuration, Apple
  packaging, the settled KMP/Compose desktop client, tests, and Apple docs.
- Anything under `core/`, `desktop_bridge/`, generated UniFFI output, Rust
  Cargo manifests, or wire/API contracts is a Windows-lane handoff. The Apple
  lane never edits generated bindings by hand.
- "macOS app" in the v1 plan means the settled KMP Compose Desktop client plus
  the existing macOS CLI distribution. There is no live native macOS SwiftUI
  app, and adding one or enabling Mac Catalyst would be an unapproved second UI
  stack.

## 2. Current truth and immediate blockers

- Xcode is installed and selected at `/Applications/Xcode.app`; the observed
  CLI reports Xcode 26.6, build 17F113. Do not install Xcode, runtimes, or other
  components automatically. The current sandbox could not connect to
  CoreSimulatorService or CoreDeviceService, so simulator/device enumeration
  must be repeated in an authorized host context. That result is not evidence
  that runtimes or devices are absent.
- `IOS-V050-1` already has a writer patch and a 56-test simulator result. Do not
  dispatch a duplicate writer. Its independent critical review is `BLOCK`:
  attempt-12 exhaustion abandons automatic delivery, an actor-reentrant stale
  flush can overwrite a retry, request-marker persistence errors are
  suppressed, and the tests do not exercise the consequential repository paths.
  A fresh `SECOND_OPINION`, then a repair plan, is mandatory.
- The reachable app root is `SCMessengerApp.swift`; `ContentView.swift` remains
  an orphaned "Hello, world!" placeholder.
- The app icon catalog declares light, dark, and tinted 1024-point slots but no
  image files. Distribution cannot be called ready until approved artwork is
  installed and rendered on device.
- There is an XCTest target and shared test scheme, but no UI-test target. Five
  current XCTest files cover backup validation, background-service scaffolding,
  notification verification, outbox retry policy, and receipt unification.
- The production `NotificationBackgroundProcessor` reports simulated network
  and fetch conditions; current notification tests include vacuous assertions.
  Simulator success cannot validate APNs, CoreBluetooth, Multipeer/AWDL, or iOS
  background scheduling.
- iOS Settings currently advertises privacy protections that the live Apple
  adapter does not activate. Android has already removed equivalent unsupported
  claims. This is an honesty/release blocker, not a request to invent core
  privacy behavior.
- The active root `shared/` module is a greeting skeleton and hardcodes the
  desktop platform name as Linux. The richer `android/shared/` Compose tree is
  not included by `settings.gradle` and its networking actuals are stubs. The
  live `desktop_bridge` lacks message, contact, history, and delivery-event
  methods. Functional macOS GUI work therefore waits on a Windows-owned bridge
  API packet.
- `bash scripts/docs_sync_check.sh` currently fails on the baseline link from
  `docs/V0.2.0_RESIDUAL_RISK_REGISTER.md` to an absent Android test. Apple
  workers must not edit that unrelated dirty documentation. The Windows
  controller must clear `XLAN-DOCSYNC-0` before authorizing an Apple commit that
  is required to satisfy the repository finalization gate.

## 3. Definition of Apple completion

Apple completion is evidence, not file presence.

### v0.5 Apple parity cut

1. Incoming requests expose durable Accept, Reject, and Block-and-Delete
   behavior with visible failures.
2. Outbound delivery UI distinguishes queued, custody accepted/forwarding,
   sent, receipt-confirmed delivered, retryable failure, and terminal identity
   rejection without regressing a stronger state.
3. A retained delivery obligation continues opportunistic automatic retry;
   manual retry accelerates the same durable envelope and is atomic with
   enqueue, flush, receipt removal, and restart.
4. Blocked peers are reachable from Settings and safely unblocked.
5. Physical iPhone-to-Android and iPhone-to-iPhone evidence proves dual-service
   mDNS where applicable, BLE cross-platform delivery, receipt truth, restart
   persistence, and route-loss recovery. Multipeer is an iOS-to-iOS assist, not
   a substitute for Android interoperability.
6. Windows closes or explicitly blocks the three Android parity handoffs in
   section 8; "iOS equals Android" is not claimed while the Android reference
   is destructive or hides failure state.
7. The bilateral four-node gate in section 11 passes on one immutable runtime:
   Windows CLI, Pixel Android, macOS CLI, and physical iPhone, with reciprocal
   CAO/CTO evidence and acknowledgment. The separate five-node cloud-custody
   gate remains mandatory where the release plan requires it.

### v1.0 Apple release cut

In addition to the v0.5 cut:

1. No production simulation, placeholder root, force-unwrap lifecycle crash
   hazard, false privacy promise, missing app artwork, or vacuous release test
   remains in the Apple surface.
2. User-visible Apple flows have localized English source strings, VoiceOver
   labels/hints, Dynamic Type coverage, non-color state cues, and tested error
   presentation.
3. iOS passes archive/export validation, privacy-manifest review, signed-device
   smoke, TestFlight processing, fresh-install/upgrade human tests, and the
   farm C4 pillars.
4. Meeting Mode passes the operator-approved 6-10-device foreground design and
   FD-4 twice with mixed iOS/Android devices. Apple UI alone cannot satisfy it.
5. The KMP macOS client is wired to real node APIs, can initialize/restore an
   identity, list contacts, send/receive, display receipt-backed delivery,
   survive restart, and interoperate with iOS, Android, and CLI. No production
   networking stub or preview-only state is accepted.
6. macOS artifacts are versioned, universal where promised, signed, notarized,
   stapled, Gatekeeper-clean, and accompanied by checksums/provenance.
7. Applicable final farm drills pass twice, including mixed-room, overnight
   custody drain, stale rejoin, and zero false-delivery UI.
8. The section-11 bilateral gate remains green as a regression contract; later
   branch merges do not orphan its immutable IDs or evidence chain.

## 4. Dependency graph and fan-out policy

```text
APPLE-GOV-0 (satisfied for branch work only) ---> isolated gpt/* dispatch/PR
XLAN-DOCSYNC-0 ---------------------------------> commit/finalizer readiness
MAINLINE-FREEZE --------------------------------> merge/tag/release waits

IOS-V050-1-SO -> IOS-V050-1-PLAN -> IOS-V050-1-R2 -> IOS-V050-1-VAL
                                                    -> IOS-V050-2
                                                    -> IOS-V050-3 -> APPLE-050-CUT

Read-only scans (parallel now):
  IOS-V1-BLE-SCAN
  IOS-V1-BACKUP-SCAN
  IOS-V1-NOTIFY-SCAN
  IOS-V1-RELEASE-SCAN
  MAC-V1-KMP-SCAN

APPLE-050-CUT -> iOS quality packets -> iOS device matrix -> archive/TestFlight
              -> Meeting Apple adapter/UI (after XLAN-MEETING-DESIGN/API)

XLAN-DESKTOP-API -> MAC-V1-KMP-FOUNDATION -> MAC-V1-KMP-MESSAGING
                  -> MAC-V1-KMP-SYSTEM -> MAC-V1-KMP-PACKAGE -> MAC-V1-KMP-QA
```

`FAN OUT NOW` means a controller may dispatch it immediately without source
overlap. `WAIT` means its named dependency or human gate must be recorded first.
Scanners and reviewers write only controller-assigned `tmp/orchestration/`
artifacts.

## 5. Verification profiles

Every source packet names one or more profiles below. Replace angle-bracket
tokens with resolved values in the packet before dispatch. All output and
result bundles stay under that packet's isolated repo-local `tmp/` directory.

### XCODE-A: unsigned build plus full simulator tests

Preflight only; it must not start a download:

```text
xcode-select -p
xcodebuild -version
xcrun simctl list runtimes
xcrun simctl list devices available
```

The controller selects an actually available iPhone UDID, not a hardcoded
device name, then runs:

```text
mkdir -p tmp/xcode-derived/<PACKET> tmp/xcode-results
python3 scripts/build_lock.py --holder <PACKET>-ios-build --wait-seconds 1800 --run "xcodebuild -quiet -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessenger -configuration Debug -destination 'generic/platform=iOS' -derivedDataPath tmp/xcode-derived/<PACKET>-device CODE_SIGNING_ALLOWED=NO build"
python3 scripts/build_lock.py --holder <PACKET>-ios-test --wait-seconds 1800 --run "xcodebuild test -quiet -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessengerTests -configuration Debug -destination 'platform=iOS Simulator,id=<SIMULATOR_UDID>' -derivedDataPath tmp/xcode-derived/<PACKET>-sim -resultBundlePath tmp/xcode-results/<PACKET>.xcresult CODE_SIGNING_ALLOWED=NO"
```

The complete test inventory and failures must be retained; an `xcresult`
summary with hidden tests is insufficient.

### XCODE-B: binding, wiring, rules, and finalization

```text
./scripts/verify_ios_bindings.sh
python3 scripts/check_wiring.py
bash scripts/docs_sync_check.sh
python3 scripts/orchestration_contract.py
git diff --check -- <EXACT_OWNED_PATHS>
```

`verify_ios_bindings.sh` regenerates into a comparison area and must show no
drift. A generated change means the packet stops and hands the API/core work to
Windows. The controller runs the repository `finalize-checklist` before any
commit, stages only the exact owned paths, and performs the full secret scan.
The known docs-sync baseline failure is closed by `XLAN-DOCSYNC-0`, not waived
or repaired by an Apple feature worker.

### XCODE-C: signed physical iPhone install and launch

Requires the operator's unlocked iPhone, trust pairing, signing team, and an
authorized host context:

```text
xcrun devicectl list devices
python3 scripts/build_lock.py --holder <PACKET>-ios-device --wait-seconds 1800 --run "xcodebuild -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessenger -configuration Debug -destination 'id=<XCODE_DEVICE_ID>' -derivedDataPath tmp/xcode-derived/<PACKET>-physical DEVELOPMENT_TEAM=<TEAM_ID> CODE_SIGN_STYLE=Automatic -allowProvisioningUpdates build"
xcrun devicectl device install app --device <COREDEVICE_ID> tmp/xcode-derived/<PACKET>-physical/Build/Products/Debug-iphoneos/SCMessenger.app
xcrun devicectl device process launch --device <COREDEVICE_ID> SovereignCommunications.SCMessenger
```

Never uninstall or erase an app/device as a convenience. A fresh-install test
uses a dedicated operator-approved device/simulator or explicit deletion
approval. Record app SHA/provenance, UTC window, node IDs, message IDs, route,
receipt, app state, and complete relevant logs.

### XCODE-D: archive and export validation

```text
mkdir -p tmp/xcode-archives/<PACKET> tmp/xcode-exports/<PACKET>
python3 scripts/build_lock.py --holder <PACKET>-archive --wait-seconds 3600 --run "xcodebuild archive -project iOS/SCMessenger/SCMessenger.xcodeproj -scheme SCMessenger -configuration Release -destination 'generic/platform=iOS' -archivePath tmp/xcode-archives/<PACKET>/SCMessenger.xcarchive DEVELOPMENT_TEAM=<TEAM_ID> CODE_SIGN_STYLE=Automatic -allowProvisioningUpdates"
xcodebuild -exportArchive -archivePath tmp/xcode-archives/<PACKET>/SCMessenger.xcarchive -exportPath tmp/xcode-exports/<PACKET> -exportOptionsPlist iOS/ExportOptions-TestFlight.plist -allowProvisioningUpdates
```

Upload to App Store Connect is an outward-facing human/account action and is
not implied by a successful export.

### MAC-KMP: macOS desktop build and package

After the Windows bridge gate and bindings generation:

```text
./gradlew :shared:tasks --all
./gradlew :shared:desktopTest
./gradlew :shared:run
./gradlew :shared:packageDmg
```

The task inventory is read in full before selecting packaging tasks. Rust/core
verification and Kotlin binding generation are Windows-authoritative; the Mac
run proves the macOS UI/package only. Release candidates additionally run:

```text
codesign --verify --deep --strict --verbose=4 <APP_OR_BINARY>
spctl --assess --type execute --verbose=4 <APP_OR_BINARY>
pkgutil --check-signature <PKG_IF_PRESENT>
```

Notarization submission uses operator-held credentials and requires explicit
outward-action authorization; the ticket must retain the submission ID and
stapler validation.

## 6. v0.5 parity packets

### IOS-V050-1-SO — delivery contract second opinion

State: `FAN OUT NOW`; role `SECOND_OPINION`; writable tracked paths: none.

Read the current scoped patch, the complete critical review, the active
five-node delivery contract, and the live outbox/repository implementation.
Return one bounded repair direction that preserves indefinite automatic
opportunity retry, atomic persistence under actor reentrancy, receipt truth,
and durable request rejection. Escalate any API/wire/core choice to the
operator. Acceptance: resolves every blocking finding explicitly and names
deterministic test seams; no source edit.

### IOS-V050-1-PLAN — repair packet

State: `WAIT` on `IOS-V050-1-SO`; role `PLANNER`; tracked paths: none.

Produce attempt-2 acceptance criteria without adopting a lifetime retry cap.
The plan must include interleavings for manual retry vs suspended flush,
receipt removal vs flush, enqueue vs flush, legacy Codable input, restart,
block failure, and request-marker write failure. Acceptance: independent
`VALIDATOR` says the packet implements the second-opinion direction and does
not require core/Rust.

### IOS-V050-1-R2 — atomic retained delivery repair

State: `WAIT`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v050-delivery-r2`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
- `iOS/SCMessenger/SCMessenger/ViewModels/ChatViewModel.swift`
- `iOS/SCMessengerTests/OutboxRetryPolicyTests.swift`

Acceptance: implement the approved transaction/revision or fresh-state merge
model; no finite lifetime automatic-retry terminal; manual retry schedules the
same envelope once; terminal identity rejection remains non-retryable;
request-marker persistence errors surface; all named interleavings are
deterministic repository-level tests. Run XCODE-A/B. Required reviews:
`VALIDATOR`, fresh `CRITICAL_VALIDATOR`, then `RELEASE_GATEKEEPER` for the
bounded delivery cut.

### IOS-V050-2 — reachable requests, blocked peers, delivery status

State: `WAIT` on accepted `IOS-V050-1-R2`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v050-parity-ui`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/BlockedPeersView.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings` (new)
- `iOS/SCMessengerTests/ParityUISurfaceTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance is the bounded contract in `CAO-V050-PLAN.md`, amended so retryable
failure never means automatic delivery has stopped. Requests visibly support
Accept, Reject, and confirmation-gated Block and Delete; Settings reaches a
loading/error/empty/list Blocked Peers view; outbound messages expose truthful
accessible states and one manual acceleration control only when eligible.
Every new source/test/resource is registered and reachable. Run XCODE-A/B plus
physical VoiceOver and accessibility-size smoke. Reviews: `VALIDATOR`,
`CRITICAL_VALIDATOR` for delivery/request semantics, `RELEASE_GATEKEEPER`.

### IOS-V050-3 — discovery and cross-platform physical proof

State: `WAIT` on `IOS-V050-2`; role `EVIDENCE`; tracked paths: none.

Use XCODE-C and the same-SHA Android artifact. Prove Android `_p2p._udp`
resolution, legacy `_scmessenger._tcp` resolution with a second iOS node or
controlled fixture, real message plus receipt, browsing restart without
duplicate amplification, BLE cross-platform delivery, app restart, and route
loss/recovery. Do not rewrite mDNS or address selection inside an evidence
task. Any failure becomes a fresh scanner packet. Required review:
`CRITICAL_VALIDATOR` over the complete synchronized evidence.

### APPLE-050-CUT — bilateral parity verdict

State: `WAIT` on `IOS-V050-3`, accepted Android handoffs, and a complete
section-11 four-node run; role `RELEASE_GATEKEEPER`; tracked paths: none.

Score the immutable four-node evidence and the still-separate five-node/cloud
requirements against the v0.5 definition in section 3. Acceptance requires
reciprocal CAO/CTO acknowledgment of the same candidate, evidence hashes, and
verdict. Missing Windows/Android evidence, missing Apple evidence, a critical
review block, or any unaccounted directional message is `BLOCKED`; this packet
cannot issue a release, tag, or merge decision.

## 7. iOS v1 packets

### Read-only packets that can fan out now

These five packets are independent and use no tracked writable paths.

#### IOS-V1-BLE-SCAN

Role `SCANNER`. Trace every reachable lifecycle and send call in
`BLECentralManager.swift`, `BLEPeripheralManager.swift`,
`BLEL2CAPManager.swift`, `MultipeerTransport.swift`,
`SmartTransportRouter.swift`, and `MeshRepository.swift`. Explicitly adjudicate
the force-unwrapped managers, intentional-disconnect tracking, the unsignaled
validation semaphore, optimistic off-main send result, unsubscribe behavior,
and whether each suspicious method is reachable. Output a repair DAG and
physical test matrix. Delivery/transport findings require `CRITICAL_VALIDATOR`.

#### IOS-V1-BACKUP-SCAN

Role `SCANNER`. Trace current Keychain backup creation, restore, upgrade, wipe,
and the legacy `SCMessenger-Backup-Placeholder` fallback through reachable call
sites. Produce compatibility cohorts and evidence; do not remove the fallback.
Escalate migration/retention/security policy to operator plus
`CRITICAL_VALIDATOR`.

#### IOS-V1-NOTIFY-SCAN

Role `SCANNER`. Classify every notification/background test as behavioral,
injected-seam, vacuous, or hardware-only; trace all production `simulate` paths
to callers; inventory BGTask identifiers, categories/actions, permission flow,
foreground routing, and state restoration. Specify what simulator, signed
device, TestFlight, and human evidence can honestly prove. No APNs architecture
is inferred.

#### IOS-V1-RELEASE-SCAN

Role `SCANNER`. Inventory bundle/build versions, signing settings, capabilities,
privacy manifest/API reasons, `Info.plist` usage strings/background modes,
export-compliance questions, assets, archive configuration, store metadata,
and CI. Return a deficiency list; do not change Apple account or Xcode signing
state.

#### MAC-V1-KMP-SCAN

Role `SCANNER`. Treat root `shared/` as the only included module and
`android/shared/` as an orphan candidate, not an implementation source of
truth. Map reusable UI, stubbed platform actuals, missing bridge APIs, generated
binding inputs, Gradle tasks, macOS resource/packaging gaps, and tests. Produce
the exact API handoff for Windows and a no-stub UI decomposition. Do not edit
`desktop_bridge/`, Cargo files, or generated Kotlin.

### Immediate post-v0.5 quality packets

#### IOS-V1-ROOT — remove the orphan launch placeholder

State: `WAIT` on `APPLE-050-CUT`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-app-root`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/SCMessengerApp.swift`
- `iOS/SCMessenger/SCMessenger/ContentView.swift`
- `iOS/SCMessengerTests/AppRootStateTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Replace the orphan placeholder with a small, reachable app-root state view used
by `SCMessengerApp`. Test preparing, onboarding, ready, and recoverable-startup
states without starting transports. Acceptance: implementation exists, the
real `@main` root calls it, and the call site is reachable. Run XCODE-A/B.
Reviews: `VALIDATOR` and `RELEASE_GATEKEEPER`.

#### IOS-V1-PRIVACY-HONEST — truthful Apple privacy controls

State: `WAIT` on `IOS-V050-2`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-privacy-honesty`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift`
- `iOS/SCMessenger/SCMessenger/ViewModels/SettingsViewModel.swift`
- `iOS/SCMessengerTests/PrivacySurfaceTests.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Remove or visibly disable claims/toggles for onion routing, cover traffic,
padding, and timing protection unless the live Apple adapter proves a reachable
core call. Preserve only truthful controls. Tests assert unavailable features
cannot be persisted as enabled and copy does not imply activation. No core or
generated change. Run XCODE-A/B. Reviews: `VALIDATOR`, `CRITICAL_VALIDATOR` for
privacy truth, `RELEASE_GATEKEEPER`.

#### IOS-V1-BACKGROUND-TRUTH — replace simulated production diagnostics

State: `WAIT` on `IOS-V1-NOTIFY-SCAN`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-background-truth`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Background/NotificationBackgroundProcessor.swift`
- `iOS/SCMessenger/SCMessenger/Services/MeshBackgroundService.swift`
- `iOS/SCMessenger/SCMessenger/Utils/NotificationLogger.swift`
- `iOS/SCMessengerTests/NotificationVerificationTests.swift`
- `iOS/SCMessengerTests/MeshBackgroundServiceTests.swift`

Production reporting must use actual OS state or state plainly that it is
unknown; test simulation lives only behind injected test seams. Remove vacuous
assertions and make failures observable. Do not promise continuous background
execution or add push infrastructure. Acceptance covers registration,
expiration, cancellation, permission denial, category actions, persisted log
bounds, and foreground/background transitions. Run XCODE-A/B and XCODE-C for
BGTask/notification human evidence. Reviews: `VALIDATOR`,
`CRITICAL_VALIDATOR`, `RELEASE_GATEKEEPER`.

#### IOS-V1-ACTION-ERRORS — visible contact/topic action failures

State: `WAIT` on `IOS-V050-2`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-action-errors`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/ViewModels/ContactsViewModel.swift`
- `iOS/SCMessenger/SCMessenger/Data/TopicManager.swift`
- `iOS/SCMessenger/SCMessenger/Views/Contacts/ContactsListView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Topics/JoinMeshView.swift`
- `iOS/SCMessengerTests/ActionFailurePresentationTests.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

No user action may swallow a repository failure, dismiss on failure, or present
success before persistence. QR/manual import validation reports actionable
errors without dialing unchecked data. Run XCODE-A/B and signed camera/QR smoke
under XCODE-C. Reviews: `VALIDATOR`, `CRITICAL_VALIDATOR` for untrusted address
ingress, `RELEASE_GATEKEEPER`.

### Packets derived from the scans

#### IOS-V1-BLE-LIFECYCLE

State: `WAIT` on accepted `IOS-V1-BLE-SCAN` plan and v0.5 delivery integration;
role `PLATFORM_IMPLEMENTER`; branch `gpt/ios-v1-ble-lifecycle`.

Maximum owned paths, reduced by the scanner before dispatch:

- `iOS/SCMessenger/SCMessenger/Transport/BLECentralManager.swift`
- `iOS/SCMessenger/SCMessenger/Transport/BLEPeripheralManager.swift`
- `iOS/SCMessenger/SCMessenger/Transport/BLEL2CAPManager.swift`
- `iOS/SCMessenger/SCMessenger/Transport/MultipeerTransport.swift`
- `iOS/SCMessengerTests/BLELifecyclePolicyTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance: explicit initialization state instead of crash-prone IUOs;
intentional stop/disconnect never triggers reconnect; unexpected loss uses
bounded deduplicated reconnect; validation has a real completion signal or is
removed with all call sites; unsubscribe does not create storms; off-main send
never reports success before acceptance. Run XCODE-A/B plus a two-iPhone and
iPhone/Android XCODE-C matrix with disconnect/reconnect and 30-minute soak.
Reviews: `VALIDATOR`, independent `CRITICAL_VALIDATOR`,
`RELEASE_GATEKEEPER`.

#### IOS-V1-BLE-DELIVERY

State: `WAIT` on `IOS-V1-BLE-LIFECYCLE`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-ble-delivery`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Transport/SmartTransportRouter.swift`
- `iOS/SCMessenger/SCMessenger/Transport/LocalTransportFallback.swift`
- `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
- `iOS/tests/local_transport_fallback_tests.swift`
- `iOS/SCMessengerTests/LocalDeliveryIntegrationTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance: local carrier acceptance is never displayed as delivery; receipt
identity governs delivered; fallback does not duplicate history/envelopes;
Multipeer remains iOS-only and BLE remains cross-platform; route loss promotes
the existing obligation. Run XCODE-A/B/C and full critical review.

#### IOS-V1-BACKUP-MIGRATION

State: `WAIT` on operator-approved policy from `IOS-V1-BACKUP-SCAN`; role
`PLATFORM_IMPLEMENTER`; branch `gpt/ios-v1-backup-migration`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
- `iOS/SCMessenger/SCMessenger/Utils/BackupPassphraseValidator.swift`
- `iOS/SCMessengerTests/BackupPassphraseValidatorTests.swift`
- `iOS/SCMessengerTests/BackupMigrationTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance is operator-selected compatibility behavior for fresh, current,
legacy-placeholder, corrupt, missing-Keychain, upgrade, and wipe cohorts. Never
silently destroy an identity. Run XCODE-A/B plus operator-approved upgrade and
wipe device tests. Reviews: `VALIDATOR`, `CRITICAL_VALIDATOR`,
`RELEASE_GATEKEEPER`.

### Localization and accessibility serial lane

The string catalog and `project.pbxproj` are shared hotspots. Run these packets
serially after functional UI settles; no two own the catalog concurrently.

#### IOS-V1-L10N-A — onboarding, contacts, topics

Owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Onboarding/OnboardingFlow.swift`
- `iOS/SCMessenger/SCMessenger/ViewModels/OnboardingViewModel.swift`
- `iOS/SCMessenger/SCMessenger/Views/Contacts/ContactsListView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Contacts/VerifySafetyNumberSheet.swift`
- `iOS/SCMessenger/SCMessenger/Views/Topics/JoinMeshView.swift`
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessengerTests/LocalizationContractTests.swift` (new)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

#### IOS-V1-L10N-B — navigation, chat, requests, notifications

Owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift`
- `iOS/SCMessenger/SCMessenger/Views/NotificationGuidanceView.swift`
- `iOS/SCMessenger/SCMessenger/Services/NotificationManager.swift`
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessengerTests/LocalizationContractTests.swift`

#### IOS-V1-L10N-C — dashboard, settings, diagnostics, backup

Owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Dashboard/MeshDashboardView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/BlockedPeersView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/DiagnosticsView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/IdentityBackupSheets.swift`
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessengerTests/LocalizationContractTests.swift`

For all three: role `PLATFORM_IMPLEMENTER`; branches `gpt/ios-v1-l10n-a`,
`-b`, `-c`; state `WAIT` on preceding UI packets. Acceptance: no user-visible
literal in owned views lacks an English catalog entry; formatting uses typed
arguments rather than concatenated translated fragments; icon-only controls
have localized labels/hints; state is not color-only; XXL accessibility text,
VoiceOver order, button hit targets, Reduce Motion, dark/light, and landscape
are physically checked. Run XCODE-A/B/C. Reviews: `VALIDATOR`,
`RELEASE_GATEKEEPER`.

### Product/security-gated iOS features

#### IOS-V1-URL-INGRESS

State: `WAIT` on operator choice of custom scheme versus associated HTTPS
domain and a security-approved payload contract. Role `PLATFORM_IMPLEMENTER`;
branch `gpt/ios-v1-url-ingress`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Info.plist`
- `iOS/SCMessenger/SCMessenger/SCMessengerApp.swift`
- `iOS/SCMessenger/SCMessenger/Services/InboundURLRouter.swift` (new)
- `iOS/SCMessenger/SCMessenger/Views/Contacts/ContactsListView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Topics/JoinMeshView.swift`
- `iOS/SCMessengerTests/InboundURLRouterTests.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`
- `iOS/SCMessenger/SCMessenger/SCMessenger.entitlements` (new only if the
  operator chooses associated domains)

Acceptance: strict version, size, character, address, identity, and action
allowlists; malformed/untrusted input never auto-dials, auto-adds, or joins;
user confirmation precedes consequential action; locked/not-ready app routing
is deterministic. Run XCODE-A/B/C. Reviews: `CRITICAL_VALIDATOR` mandatory,
then `VALIDATOR` and `RELEASE_GATEKEEPER`.

#### IOS-V1-APP-SHARE-A — iOS-to-iOS install link

State: `WAIT` on Apple Developer Program and operator selection. Default
recommendation is TestFlight-link sharing for broad v1 pilots; Ad Hoc OTA is a
separate UDID-managed product and must not be presented as unrestricted iOS
sideloading. Role `PLATFORM_IMPLEMENTER`; branch `gpt/ios-v1-app-share`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Views/Settings/SettingsView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Settings/AppShareView.swift` (new)
- `iOS/SCMessengerTests/AppShareContractTests.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance: generated QR/share content is exactly the operator-approved HTTPS
TestFlight link, labels disclose online/Apple requirements, invalid or absent
configuration disables sharing, and no IPA is bundled or hosted. Ad Hoc, if
chosen instead, requires a new planner/security packet. Run XCODE-A/B/C.

#### IOS-V1-APP-SHARE-B — iOS hosts Android artifact

State: `WAIT` on `APP-SHARE-A`, signed Android artifact provenance contract,
storage/capacity policy, and security review. This is not bundled into the
first PR. A fresh planner must bound the exact hosting service and paths; an
HTTP listener, APK retention, QR ingress, and local-network exposure are
security/release decisions. Required reviewers: `CRITICAL_VALIDATOR` and
`RELEASE_GATEKEEPER`.

#### IOS-V1-MEETING-ADAPTER-UI

State: `WAIT` on `XLAN-MEETING-DESIGN` and Windows core/API integration. Role
`PLATFORM_IMPLEMENTER`; branch `gpt/ios-v1-meeting-mode`.

Provisional maximum owned paths, narrowed by the approved design:

- `iOS/SCMessenger/SCMessenger/Transport/MultipeerTransport.swift`
- `iOS/SCMessenger/SCMessenger/Transport/BLECentralManager.swift`
- `iOS/SCMessenger/SCMessenger/Transport/BLEPeripheralManager.swift`
- `iOS/SCMessenger/SCMessenger/Data/MeshRepository.swift`
- `iOS/SCMessenger/SCMessenger/Views/Navigation/MainTabView.swift`
- `iOS/SCMessenger/SCMessenger/Views/Meeting/MeetingModeView.swift` (new)
- `iOS/SCMessengerTests/MeetingModePolicyTests.swift` (new)
- `iOS/SCMessenger/SCMessenger/Localizable.xcstrings`
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`

Acceptance: explicit foreground-only state; bounded connection budget and
rotation from the approved design; Multipeer offload for iOS pairs; BLE path
for Android pairs; honest participant/route/delivery state; stop returns to
normal routing without orphan tasks. XCODE-A/B plus FD-4 physical evidence is
mandatory. Reviews: `CRITICAL_VALIDATOR`, `VALIDATOR`,
`RELEASE_GATEKEEPER`.

### Release and TestFlight lane

#### IOS-V1-ASSETS

State: `WAIT` on operator-approved brand artwork; role `PLATFORM_IMPLEMENTER`;
branch `gpt/ios-v1-release-assets`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/Assets.xcassets/AppIcon.appiconset/Contents.json`
- approved new image files under
  `iOS/SCMessenger/SCMessenger/Assets.xcassets/AppIcon.appiconset/`
- approved new launch/brand assets under
  `iOS/SCMessenger/SCMessenger/Assets.xcassets/`

Acceptance: opaque 1024x1024 source, correct light/dark/tinted assignments,
no alpha where Apple forbids it, no placeholder, asset compiler clean, legible
small-size home-screen rendering in light/dark/tinted modes. Run XCODE-A/C and
visual `VALIDATOR`; operator approves appearance.

#### IOS-V1-COMPLIANCE

State: `WAIT` on `IOS-V1-RELEASE-SCAN`, privacy/legal answers, and settled
features; role `PLATFORM_IMPLEMENTER`; branch `gpt/ios-v1-compliance`.

Exclusive owned paths:

- `iOS/SCMessenger/SCMessenger/PrivacyInfo.xcprivacy`
- `iOS/SCMessenger/SCMessenger/Info.plist`
- `iOS/SCMessenger/SCMessenger/SCMessenger.entitlements` (only if approved)
- `iOS/SCMessenger/SCMessenger.xcodeproj/project.pbxproj`
- `docs/privacy_policy.md`
- `docs/platform/IOS_SETUP.md`

Acceptance: manifest and disclosures match reachable collection/access APIs;
usage strings describe actual use; capabilities are minimal; export
compliance, encryption, age/category, retention, diagnostics, and contact data
answers are operator/legal-approved. No entitlement is added speculatively.
Run XCODE-A/B/C and App Store archive validation. Reviews:
`CRITICAL_VALIDATOR` for privacy, `DOCS_SYNC_AUDITOR`,
`RELEASE_GATEKEEPER`.

#### IOS-V1-ARCHIVE-PIPELINE

State: `WAIT` on Apple account/team, final post-PQC binding refresh from
Windows, assets, and compliance; role `PLATFORM_IMPLEMENTER`; branch
`gpt/ios-v1-testflight-pipeline`.

Exclusive owned paths:

- `iOS/ExportOptions-TestFlight.plist` (new)
- `scripts/archive_ios.sh` (new)
- `.github/workflows/ios-build-test.yml`
- `.github/workflows/ios-testflight.yml` (new, manual/tag protected trigger)
- `iOS/README.md`
- `iOS/XCODE_SETUP.md`

Acceptance: archive script never mutates committed generated bindings, never
downloads Xcode, writes outputs only under repo-local `tmp/`, fails closed on
missing signing/account inputs, and separates build/export from upload.
Workflow uses protected environments and no secret echo. Run XCODE-A/B/D on
Mac; PR CI green. Reviews: `VALIDATOR`, `DOCS_SYNC_AUDITOR`, security review of
credential handling, `RELEASE_GATEKEEPER`.

#### IOS-V1-TESTFLIGHT-EVIDENCE

State: `WAIT`; role `EVIDENCE`; tracked paths: none.

The operator performs/authorizes upload and tester provisioning. Acceptance:
App Store processing succeeds; fresh install and upgrade from the designated
prior build both preserve the approved identity/data behavior; onboarding,
permissions, notifications, QR camera, background transitions, BLE, mDNS,
receipt, retry, diagnostics export, and crash-free relaunch pass on at least
two iPhone models/OS versions. Record exact build number and TestFlight SHA
provenance. External review or Apple rejection remains `BLOCKED`, never
silently waived.

#### IOS-V1-VERSION-RELEASE

State: `WAIT` on all release gates; Windows orchestrator owned. The Apple lane
does not independently bump shared versions, tag, merge main, or publish.
Windows runs the canonical version-sync path, final bindings generation, full
Windows/Android gates, then hands the exact commit to Mac for final XCODE-D and
TestFlight evidence. Any `MARKETING_VERSION`/`CURRENT_PROJECT_VERSION` edit is
part of that bounded release commit, not a work-ahead feature PR.

## 8. Windows/Android and core handoffs

These packets are required for honest parity. Apple workers do not edit their
paths.

### XLAN-DOCSYNC-0 — restore canonical finalization baseline

Owner: Windows orchestrator/docs worker. Fix or supersede the broken canonical
link reported by `scripts/docs_sync_check.sh`, then prove the complete script
passes. Do not commit any of the unrelated dirty files in the shared checkout.

### AND-V050-1 — non-destructive request enumeration

Owned paths:

- `android/app/src/main/java/com/scmessenger/android/data/MeshRepository.kt`
- `android/app/src/test/java/com/scmessenger/android/test/MessageRequestEnumerationTest.kt` (new)

Two consecutive listings return the same IDs and never consume normal inbox
data. Binding absence escalates to an API packet; generated Kotlin is not
edited. Critical review required.

### AND-V050-2 — failed-event delivery truth

Owned paths:

- `android/app/src/main/java/com/scmessenger/android/ui/viewmodels/ChatViewModel.kt`
- `android/app/src/test/java/com/scmessenger/android/test/ChatViewModelTest.kt`

An unacknowledged failure is observable; sent/delivered never regress. Critical
review required.

### AND-V050-3 — mDNS permission/test fidelity

Owned paths:

- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/java/com/scmessenger/android/utils/Permissions.kt`
- `android/app/src/test/java/com/scmessenger/android/transport/MdnsServiceDiscoveryTest.kt`

API 29-32 and 33+ permission policy is explicit and tests exercise the
production `_p2p._udp` service. Windows build plus physical Pixel and
`android-qa` review required.

### XLAN-MEETING-DESIGN and XLAN-MEETING-API

Owner: Windows orchestrator, `PLANNER`, operator, then Rust implementer and
mandatory adversarial review. The design must settle group-thread scope,
connection budget/rotation, charging/GO-intent heuristics, gossipsub room
topic, BLE fragmentation caps/timeouts, Multipeer offload, and UI truth for
6-10 foreground mixed devices. Apple implementation waits for a reviewed API;
it may not invent a Swift-only meeting protocol.

### XLAN-DESKTOP-API

Owner: Windows orchestrator/Rust lane. Extend the real `DesktopBridge` through
`IronCore` with the minimum reviewed lifecycle, identity, contact listing,
conversation/history, send/retained-obligation state, receipt/delivery event,
request, and settings surfaces needed by the KMP client. Regenerate Kotlin;
prove reachable call sites and Windows-authoritative workspace/build gates.
Any touch under core crypto/transport/routing/privacy requires the repository's
adversarial review. Apple receives only a committed reviewed API and generated
bindings.

### AND-V1-APP-SHARE

Owner: Windows Android lane after the iOS channel decision. Android may render
and share the approved TestFlight/Ad Hoc URL, but must disclose Apple/network
requirements and must not imply it can sign or install an arbitrary IPA. The
iOS-hosts-APK direction uses a signed Android artifact with verifiable SHA and
retention policy; both directions require security review.

### AND-V1-MEETING and AND-V1-FARM

Owner: Windows Android lane. Implement the approved Meeting adapter/UI and run
the same FD-4 all-pairs/30-minute/zero-loss evidence. Close current Android
parity deficiencies before mixed-room certification: non-destructive requests,
visible failures, production mDNS test fidelity, BLE concurrent-GATT behavior
on actual farm phones, permissions, background/foreground recovery, and
delivery-state truth. Android build results are Windows/physical-Pixel
authoritative, not inferred from Apple success.

## 9. macOS packets

### MAC-V1-CLI-PACKAGE

State: `WAIT` on Developer ID credentials and release policy; role
`PLATFORM_IMPLEMENTER`; branch `gpt/macos-v1-cli-package`.

Exclusive owned paths:

- `.github/workflows/release.yml`
- `scripts/package_macos_cli.sh` (new)
- `docs/CLI_MACOS.md`

No Rust source is changed. Package the Windows-produced/release-built arm64 and
x86_64 CLI artifacts into the operator-approved universal binary or explicit
per-architecture artifacts; preserve checksums/provenance; sign, notarize,
staple, and verify with `codesign`, `spctl`, and `pkgutil` where applicable.
Notarization credentials live only in protected CI/operator keychain. Reviews:
`VALIDATOR`, `DOCS_SYNC_AUDITOR`, credential-security review,
`RELEASE_GATEKEEPER`.

### MAC-V1-KMP-FOUNDATION

State: `WAIT` on approved `MAC-V1-KMP-SCAN` architecture and
`XLAN-DESKTOP-API`; role `PLATFORM_IMPLEMENTER`; branch
`gpt/macos-v1-kmp-foundation`.

Exclusive owned paths:

- `settings.gradle`
- `shared/build.gradle.kts`
- `shared/src/commonMain/kotlin/com/scmessenger/shared/SharedApp.kt`
- `shared/src/desktopMain/kotlin/com/scmessenger/shared/Main.kt`
- `shared/src/desktopMain/kotlin/com/scmessenger/shared/Platform.kt`
- new files under `shared/src/commonMain/kotlin/com/scmessenger/shared/app/`
- new files under `shared/src/desktopMain/kotlin/com/scmessenger/shared/platform/`
- tests under `shared/src/commonTest/` and `shared/src/desktopTest/`

Do not edit or delete `android/shared/` in this packet. Acceptance: root
`shared/` is the only canonical included desktop UI, reports macOS correctly,
initializes/stops the real bridge, presents explicit loading/error/consent/
identity states, and contains no production fake network result. Run MAC-KMP;
Windows separately verifies binding/core gates. Reviews: `VALIDATOR`,
`RELEASE_GATEKEEPER`.

### MAC-V1-KMP-MESSAGING

State: `WAIT` on foundation; role `PLATFORM_IMPLEMENTER`; branch
`gpt/macos-v1-kmp-messaging`.

Exclusive owned paths:

- new/updated files under
  `shared/src/commonMain/kotlin/com/scmessenger/shared/model/`
- new/updated files under
  `shared/src/commonMain/kotlin/com/scmessenger/shared/viewmodel/`
- new/updated files under
  `shared/src/commonMain/kotlin/com/scmessenger/shared/ui/`
- new/updated desktop adapter files under
  `shared/src/desktopMain/kotlin/com/scmessenger/shared/platform/`
- matching tests under `shared/src/commonTest/` and `shared/src/desktopTest/`

Acceptance: real contacts, requests, conversations, send, retained obligation,
receipt-backed delivery, retry acceleration, and restart state; no stub return
values, synthetic peers, or in-memory-only production history. Call sites are
reachable from `Main.kt`. Run MAC-KMP plus iOS/Android/CLI interop evidence.
Delivery semantics require `CRITICAL_VALIDATOR`.

### MAC-V1-KMP-SYSTEM

State: `WAIT` on messaging; role `PLATFORM_IMPLEMENTER`; branch
`gpt/macos-v1-kmp-system`.

Exclusive owned paths:

- new/updated files under `shared/src/commonMain/kotlin/com/scmessenger/shared/ui/settings/`
- new/updated files under `shared/src/commonMain/kotlin/com/scmessenger/shared/ui/diagnostics/`
- new/updated files under `shared/src/desktopMain/kotlin/com/scmessenger/shared/system/`
- matching tests under `shared/src/commonTest/` and `shared/src/desktopTest/`

Acceptance: truthful node/connection state, notifications, tray/unread state,
power/suspend/resume, diagnostics export, settings persistence, identity backup
and wipe confirmation according to reviewed APIs. Unsupported macOS BLE is
shown as unsupported, never successful. Run MAC-KMP and physical suspend/
resume/network-loss evidence. Reviews: `VALIDATOR`, `CRITICAL_VALIDATOR` for
privacy/delivery, `RELEASE_GATEKEEPER`.

### MAC-V1-KMP-PACKAGE

State: `WAIT` on system/UI completion and Developer ID; role
`PLATFORM_IMPLEMENTER`; branch `gpt/macos-v1-kmp-package`.

Exclusive owned paths:

- `shared/build.gradle.kts`
- new package resources under `shared/src/desktopMain/resources/`
- `scripts/build_desktop.sh`
- `scripts/build_desktop.ps1`
- `scripts/package_macos_desktop.sh` (new)
- `.github/workflows/desktop-release.yml` (new)

Acceptance: build scripts fail closed and never print success after a failed
fallback; macOS DMG/PKG uses the real app and version; signing/notarization and
Gatekeeper checks pass; Linux/Windows packaging behavior is not silently
changed. Run full MAC-KMP packaging and reviews by `VALIDATOR`, credential
security reviewer, `RELEASE_GATEKEEPER`.

### MAC-V1-KMP-QA

State: `WAIT`; role `EVIDENCE`; tracked paths: none.

On signed/notarized artifacts, prove fresh install, upgrade, identity restore,
message/request/receipt/retry/restart, suspend/resume, offline custody drain,
and interoperability with same-SHA iOS, Android, and CLI nodes. Include macOS
arm64 and either x86_64 hardware or operator-approved virtualization/waiver.
Meeting participation is required only if the approved design names desktop as
a participant. Evidence must join the v1 mixed-platform matrix.

## 10. Physical and operator gates

The controller must show these as explicit blocking state, never implicit todo
text:

| Gate | Owner | Unblocks | Passing evidence |
|---|---|---|---|
| Apple work-ahead boundary | Operator | Isolated `gpt/*` source/PR work only | Satisfied by this task directive; main merge/tag/release/HANDOFF moves remain frozen |
| CoreSimulator/CoreDevice host access | Operator/controller | XCODE-A/C | Runtime and device lists in authorized context; no duplicate download |
| Apple Developer Program/team | Operator | signing, TestFlight, app sharing | Active team, agreements, provisioning access |
| Brand artwork | Operator | IOS-V1-ASSETS | approved light/dark/tinted source assets |
| Privacy/legal/export answers | Operator/legal | IOS-V1-COMPLIANCE | signed-off disclosure matrix |
| Two iPhones plus Pixel | Operator/device coordinator | BLE/mDNS/background C4 | synchronized same-SHA logs and message IDs |
| 6-10 mixed phones/people | Operator/device coordinator | FD-4 Meeting | all-pairs, 30-minute, zero-loss run twice |
| Developer ID/notary credentials | Operator | macOS releases | protected credentials, notarization/staple evidence |
| Backup migration choice | Operator/security | IOS-V1-BACKUP-MIGRATION | explicit legacy/corrupt/wipe policy |
| URL/install channel choice | Operator/security | deep link/app share | approved payload and TestFlight vs Ad Hoc decision |
| Meeting architecture | Operator/Windows planner/security | Meeting Apple packet | reviewed D1 design and API |
| Final PQC/core binding SHA | Windows orchestrator | archive, KMP freeze | regenerated bindings from reviewed core commit |

## 11. Bilateral four-node v0.4/v0.5 field gate

The operator has made the four-node Android/iOS field test a hard bilateral
gate and an ongoing CAO/CTO coordination contract. It is an additional focused
gate, not a replacement for the five-node test that adds the cloud node and
proves remote custody/forwarding. The four-node gate isolates the two platform
lanes and makes every endpoint's evidence jointly accountable.

### 11.1 Immutable identity and tracked coordination surfaces

The initial contract has these immutable identifiers:

```text
coordination_id: AW-BILAT-0001
gate_contract_id: AW4N-V040-V050-GATE-0001
```

Never recycle or rename them. Each frozen runtime and pass receives an
append-only attempt ID:

```text
AW4N-V040-V050-GATE-0001-R<two-digit-runtime>-P<two-digit-pass>
```

For example, the first pass on the first mutually acknowledged runtime is
`AW4N-V040-V050-GATE-0001-R01-P01`. A runtime-code SHA change increments `R`
and resets pass numbering. A rerun without runtime drift increments `P`.
Documentation-only merge commits do not change `R`, but both lanes record them
as coordination commits. IDs are never edited in place or assigned from a
mutable branch name.

The coordination-doc implementer creates these stable tracked paths once:

- `HANDOFF/coordination/apple-windows/INDEX.md` — derived status/index; single
  writer is the Windows orchestration controller after it observes both lanes.
- `HANDOFF/coordination/apple-windows/CAO_TO_CTO.md` — append-only Apple-origin
  requests, recommendations, approvals, acknowledgments, and test events. The
  CAO lane is its only normal writer.
- `HANDOFF/coordination/apple-windows/CTO_TO_CAO.md` — append-only
  Windows-origin requests, recommendations, approvals, acknowledgments, and
  test events. The CTO lane is its only normal writer.
- `HANDOFF/coordination/apple-windows/FOUR_NODE_GATE.md` — immutable topology,
  matrix schema, scoring semantics, and artifact manifest contract. Amendments
  are new versioned events approved by both lanes, not silent rewrites.
- `HANDOFF/coordination/apple-windows/evidence/<TEST_ID>/APPLE.md` — redacted
  Apple evidence manifest/summary for one attempt.
- `HANDOFF/coordination/apple-windows/evidence/<TEST_ID>/WINDOWS.md` — redacted
  Windows evidence manifest/summary for one attempt.
- `HANDOFF/coordination/apple-windows/evidence/<TEST_ID>/VERDICT.md` — jointly
  acknowledged integrated verdict, written by the Windows controller after
  independent scoring.

Raw logs, crash archives, screenshots containing identifiers, build products,
and device exports are never committed. They remain under each lane's
repo-local `tmp/field-tests/<TEST_ID>/` or an operator-approved private artifact
store. The tracked evidence summaries record locator, SHA-256, byte size, UTC
coverage, collector health, redaction status, and retaining lane for every raw
artifact. No private key, message body, complete public identity, device
serial, signing secret, or personal notification text enters git.

### 11.2 Exact topology and lane roles

For the LAN phase, all four endpoints use the same non-guest IPv4 subnet; the
actual addresses are recorded at run time and never copied from an old handoff.
All run the exact mutually acknowledged runtime commit. Each is a full node
that can perform custody/forwarding behavior; role labels below describe test
and evidence ownership, not different product architectures.

| Node ID | Endpoint | Test role | Lane and evidence owner |
|---|---|---|---|
| `N1-WIN-CLI` | Windows `scmessenger-cli.exe` | Normal messaging endpoint; Windows lane driver and API/log observer | CTO/Windows |
| `N2-AND-PIXEL` | Physical Pixel 6a Android app | Normal mobile endpoint; QR, LAN, BLE, requests, UI, lifecycle | CTO/Windows |
| `N3-MAC-CLI` | MacBook macOS CLI | Normal messaging endpoint; Apple lane driver and API/log observer | CAO/Apple |
| `N4-IOS-PHONE` | Christy's physical iPhone app | Normal mobile endpoint; QR, LAN, BLE, requests, UI, lifecycle | CAO/Apple |

The cloud node is deliberately absent from this bilateral topology. It is
added by the separate five-node gate for internet route and remote
store-and-forward custody evidence. A four-node pass cannot satisfy that
five-node requirement, and a five-node pass cannot replace missing per-lane
four-node evidence.

### 11.3 Candidate freeze record

Before either lane starts a pass, both journals must contain reciprocal
`CANDIDATE_ACK` events for exactly this record:

```text
coordination_id
gate_contract_id
test_id
release_scope: V040 | V050_REGRESSION
candidate_branch
candidate_commit_full_sha
candidate_tree_sha
candidate_diff_sha256_from_last_accepted_runtime
core_source_commit_full_sha
swift_binding_checksum
kotlin_binding_checksum
windows_cli_artifact_sha256
android_apk_sha256
macos_cli_artifact_sha256
ios_app_source_sha_and_archive_uuid
apple_handoff_branch
apple_handoff_record_commit
windows_handoff_branch
windows_handoff_record_commit
node_versions_and_os_builds
node_identity_fingerprints_redacted
utc_clock_offsets
collector_preflight_status
```

The git commit, tree, generated-binding checksums, and artifact checksums are
the truth; branch names are only locators. Uncommitted runtime changes make the
candidate ineligible. Any runtime code, generated binding, build flag, or
dependency drift after acknowledgment invalidates the pass and requires a new
`R` ID. Neither lane may continue because "its side did not change."

### 11.4 Complete feature and evidence matrix

Every directional message uses a new opaque correlation ID and recorded UTC
send time. A row passes only when sender acceptance/outbox evidence,
receiver ingest/decrypt/history evidence, receiver receipt emission, and
sender receipt/outbox convergence are all present. A transport's local
"accepted" result is not delivered truth.

| Matrix ID | Applies | Required cells/procedure | PASS evidence and owner |
|---|---|---|---|
| `M00-PROVENANCE` | v0.4, v0.5 | All N1-N4 before traffic | Exact candidate/artifact/binding fields match. Each lane owns its two nodes; both acknowledge. |
| `M01-COLLECTORS` | v0.4, v0.5 | Start full collectors and watchdogs before traffic; prove they survive process restart and retain the whole window | Per-node heartbeats, start/end coverage, no ring eviction/truncation. Platform lane owns completeness. |
| `M02-IDENTITY` | v0.4, v0.5 | Existing identities survive in-place update and restart; no re-pair or wipe | Before/after redacted fingerprints and persisted contacts/history from each node. |
| `M03-FLEET` | v0.4, v0.5 | Every node converges on all other three endpoints, then reconverges after sequential restart | Full uncapped peer snapshots and discovery/ledger event chain from both lanes. |
| `M04-QR-A2I` | v0.4, v0.5 | Android exports; iPhone scans/imports; no unchecked auto-dial | Android payload provenance plus iOS validation/confirmation/contact result. Joint row. |
| `M05-QR-I2A` | v0.4, v0.5 | iPhone exports; Android scans/imports; no unchecked auto-dial | iOS payload provenance plus Android validation/confirmation/contact result. Joint row. |
| `M06-LAN-ALL-PAIRS` | v0.4, v0.5 | Both directions for all six pairs: N1-N2, N1-N3, N1-N4, N2-N3, N2-N4, N3-N4; 12 unique messages and receipts | For each direction, sending lane owns enqueue/send/outbox; receiving lane owns ingest/decrypt/history/receipt; joint score. |
| `M07-MDNS` | v0.4, v0.5 | Mobile/CLI LAN discovery on production service types; stop/start discovery once | Full service type, peer ID fingerprint, pinned address, dial result, no duplicate amplification. Platform owner supplies its events. |
| `M08-BLE-A2I` | v0.4, v0.5 | Wi-Fi disabled on Pixel and iPhone; Android to iPhone, then iPhone to Android, real payload and receipt | Central/peripheral role, service/characteristic, fragments/reassembly, ingest and receipt on both phones. Joint row. |
| `M09-BLE-CAPABILITY` | v0.4, v0.5 | Evaluate BLE for all six pairs; execute every currently supported pair/direction | Capability manifest plus evidence for supported cells. `N/A` requires exact adapter/source/hardware proof and operator acknowledgment; no silent skip. |
| `M10-REQUEST-A2I` | v0.5 | Unknown Android sender creates iOS request; iOS Accept preserves message and enables reply | Android send plus iOS durable request/accept/contact/history and bidirectional receipt evidence. |
| `M11-REQUEST-I2A` | v0.5 | Unknown iOS sender creates Android request; Android Accept preserves message and enables reply | Reciprocal evidence; Windows owns Android state, Apple owns iOS send/receipt. |
| `M12-REJECT-BLOCK` | v0.5 | Each mobile rejects one fresh unknown sender; separately confirmation-gated Block and Delete, unblock, restart | Marker/contact/conversation/block state before/after/reload; no stale resurrection; each platform owner proves its app. |
| `M13-DELIVERY-TRUTH` | v0.4 baseline, expanded v0.5 UI | Exercise queued, custody/forwarding where observed, sent, receipt-delivered, retryable transient, and terminal identity rejection | No delivered glyph/checkmark without receipt; no false failure after receipt; no state regression. Mobile owner supplies UI plus repository events; critical scorer correlates. |
| `M14-OFFLINE-OBLIGATION` | v0.4, v0.5 | Take each recipient offline in turn, accept a message, restart sender, wait beyond prior retry thresholds, restore recipient | Same durable envelope/message ID remains eligible and delivers once; no lifetime abandonment or duplicate history. Joint row. |
| `M15-ROUTE-CHANGE` | v0.4, v0.5 | Disable/re-enable Wi-Fi and BLE in controlled sequence; change viable LAN route; no app restart | Bounded recovery, existing obligation promoted, complete candidate ladder, correct receipt. Lane owning the toggled node supplies OS state; both supply delivery. |
| `M16-RESTART` | v0.4, v0.5 | Restart N1, N2, N3, N4 one at a time during queued/settled states | Collector survives, identity stable, peers reconverge, pending drains, delivered remains delivered. Per-node owner plus joint score. |
| `M17-FOUR-NODE-CHURN` | v0.4, v0.5 | All four send concurrently, direct/alternate paths present, 30-minute active churn | No panic, ANR, crash, dead node, invitation/connection storm, log flood, message loss, duplicate history, or false delivery. Both lanes own local health. |
| `M18-BACKGROUND-NOTIFY` | v0.5 | Background/foreground each mobile under operator-controlled supported conditions; receive, tap, reply/mark-read where implemented | Actual OS scheduling/notification evidence, correct route, no simulated success claim. Platform owner; unsupported APNs behavior remains blocked, not inferred. |
| `M19-DIAGNOSTICS` | v0.5 | Export diagnostics from both apps and CLI nodes after run | Complete run ID/SHA/route/error data with secrets and message content redacted. Per-platform owner. |
| `M20-SOAK` | v0.4, v0.5 | 60 minutes with all four alive after two complete matrix passes; periodic bidirectional messages and one restart/network event | Zero unaccounted messages, false delivery, crash/panic/ANR, collector gap, or identity drift. CAO and CTO co-sign. |

For v0.4, v0.5-only rows are recorded as `NOT-IN-RELEASE-SCOPE`, never
`PASS`. The v0.5 regression runs the complete table. Internet/cloud custody is
scored only in the five-node gate and remains independently mandatory.

### 11.5 Per-node artifact contract

Each lane creates the following complete tree before the run; it may add native
files but may not omit the common manifests:

```text
tmp/field-tests/<TEST_ID>/
  run-manifest.json
  matrix-results.json
  N1-WIN-CLI/
    artifact-manifest.json
    collector-health.json
    provenance.json
    events.jsonl
    peers-before.json
    peers-after.json
    outbox-before.json
    outbox-after.json
    crash-index.json
    raw/
  N2-AND-PIXEL/
    <same common files plus logcat/bugreport/ANR native artifacts under raw/>
  N3-MAC-CLI/
    <same common files plus CLI/unified/process native artifacts under raw/>
  N4-IOS-PHONE/
    <same common files plus unified logarchive, diagnostic export, and crash reports under raw/>
```

`events.jsonl` is a normalized, lossless index of every relevant event in the
captured window, not a sample. Each event carries test ID, node ID, monotonic
sequence, UTC timestamp, correlation ID, event kind, transport, peer
fingerprint, delivery state, and raw-artifact byte/line locator. When a native
collector cannot give a reliable line locator, it records the query and time
range. No `head`, `tail`, API default cap, summarized "and more," or ring-buffer
eviction is accepted as complete evidence.

Node-specific minimum raw evidence:

- N1: CLI stdout/stderr from before startup through shutdown, process/liveness
  checks, listen addresses, peer/API snapshots, crash dump/index.
- N2: logcat buffers raised before run, complete app/system window, installed
  package/version/certificate/artifact proof, diagnostics export, ANR/crash/
  tombstone index, screenshots of mobile truth states.
- N3: CLI stdout/stderr, process/liveness checks, listen addresses, peer/API
  snapshots, macOS unified-log query/coverage, crash report index.
- N4: app/Xcode or device unified-log archive for the complete window,
  installed app/version/archive UUID proof, app diagnostics export, iOS crash
  reports, screenshots of request/block/delivery/notification states.

Before scoring, the evidence worker hashes every file and checks clock coverage,
monotonic sequence, correlation-ID completeness, restart continuity, collector
heartbeat, redaction, and raw locator validity. A missing or deaf collector is
`BLOCKED-EVIDENCE`; absence inside it is never evidence that an event did not
occur.

### 11.6 Pass/fail ownership and verdict

Allowed cell states are `PASS`, `FAIL`, `BLOCKED-EVIDENCE`, `BLOCKED-HW`, and
`NOT-IN-RELEASE-SCOPE`. Only the operator may approve a release waiver, and a
waived cell remains visibly waived rather than converted to PASS.

- CAO owns correctness and completeness of N3/N4 provenance, collection,
  Apple runtime state, and Apple screenshots. CAO can fail or block Apple
  readiness but cannot pass a Windows/Android cell.
- CTO owns correctness and completeness of N1/N2 provenance, collection,
  Windows/Android runtime state, and authoritative Windows/Pixel gates. CTO can
  fail or block Windows readiness but cannot pass an Apple cell.
- For every directional message, sender-lane evidence owns acceptance/outbox;
  receiver-lane evidence owns ingest/decrypt/history/receipt. Both halves are
  necessary. Neither lane may score end-to-end PASS alone.
- A fresh independent `EVIDENCE` scorer correlates both complete manifests. A
  `CRITICAL_VALIDATOR` adjudicates delivery, custody, identity, transport,
  block/request, and retry semantics. Reviewer uncertainty fails closed.
- CAO and CTO append reciprocal acknowledgment of the same verdict commit and
  scoped evidence hashes. The Windows orchestrator then owns the v0.4/v0.5
  release-gate disposition. A release verdict cannot overrule an Apple block,
  an Android/Windows block, a critical-review block, or missing evidence.

### 11.7 Merge-resilient polling and reciprocal updates

During active coordination, each controller checks at the start and end of
every controller turn and at least every 15 minutes during a live build/test
window. Polling is read-only; it does not pull, switch, rebase, or clean the
shared checkout.

```text
git fetch origin --prune
git log --all --format='%H %cI %D %s' -S'<IMMUTABLE_ID>' -- HANDOFF/coordination/apple-windows/
git show <OBSERVED_COMMIT>:HANDOFF/coordination/apple-windows/CAO_TO_CTO.md
git show <OBSERVED_COMMIT>:HANDOFF/coordination/apple-windows/CTO_TO_CAO.md
git show origin/main:HANDOFF/coordination/apple-windows/INDEX.md
```

Read every matching commit/event; do not cap output. `git` is authoritative for
branch history. Branch name alone is never a cursor: a PR merge changes the
branch relationship, and a later branch cleanup can remove the remote ref.
The immutable item/test ID plus exact record commit lets the watcher find an
event in an open PR, a merged main history, or a successor branch. Controllers
persist `last_seen_record_commit` and `last_seen_event_sequence` in their
orchestration state; they never infer "no update" from an unchanged branch
name.

Reciprocal rules:

1. Origin appends a new event in its lane-owned journal with immutable ID,
   event sequence, origin/target, candidate branch/commit, scope, evidence,
   requested disposition, and next action; it commits on its own lane branch.
2. Target acknowledges the exact origin record commit in its own journal. It
   records `RECEIVED` plus `ACCEPTED`, `DECLINED`, `DEFERRED`, or `BLOCKED`,
   rationale, owner, evidence, and target branch/commit. Silence is not assent.
3. A correction is a new event with a new sequence and `supersedes` pointer;
   neither lane rewrites/deletes the original. A materially different request
   receives a new immutable item ID.
4. Windows controller adds the paired records to `INDEX.md` after observing
   both. The journals remain authoritative if the derived index lags.
5. No coordination branch is deleted and no request is treated as delivered
   until the exact commit has reciprocal acknowledgment or has merged to main
   and been indexed. This is the coordination exception handled within the
   48-hour policy, not a reason for a long-lived feature branch.
6. Any runtime SHA/artifact/checksum change triggers immediate reciprocal
   `CANDIDATE_INVALIDATED`, stops the run, and creates the next runtime ID.
7. Each lane posts collector start, `READY`, test-step completion, any fail,
   collector stop, manifest hash, and verdict acknowledgment. Test steps advance
   only when both lanes have acknowledged the same preceding event.

### 11.8 Immediately dispatchable four-node packets

#### COORD-AW-1 — stable bilateral coordination documents

State: `FAN OUT NOW`; role `IMPLEMENTER`; branch
`gpt/apple-windows-coordination-contract`; docs-only worktree.

Exclusive owned paths:

- `HANDOFF/coordination/apple-windows/INDEX.md` (new)
- `HANDOFF/coordination/apple-windows/CAO_TO_CTO.md` (new)
- `HANDOFF/coordination/apple-windows/CTO_TO_CAO.md` (new)
- `HANDOFF/coordination/apple-windows/FOUR_NODE_GATE.md` (new)

Implement this section's schemas and initial events for `AW-BILAT-0001` and
`AW4N-V040-V050-GATE-0001`; do not include stale IPs, runtime SHAs, or fake
evidence. The first CAO event asks CTO to acknowledge the contract and nominate
the Windows preflight owner. Acceptance: append-only lane ownership is clear,
every required field/state exists, topology/matrix/artifact/verdict/poll rules
are complete, links resolve, no application source changes. Reviews:
`VALIDATOR`, `DOCS_SYNC_AUDITOR`, then reciprocal CTO acknowledgment before the
PR is considered operational. The known unrelated docs-sync baseline is
reported and routed to `XLAN-DOCSYNC-0`, not edited in this packet.

#### AW4N-APPLE-PREFLIGHT — N3/N4 readiness manifest

State: `FAN OUT NOW`; role `EVIDENCE`; tracked paths: none; output only
`tmp/orchestration/evidence/AW4N-APPLE-PREFLIGHT.md` plus local artifact
manifests.

Without installing/downloading anything, capture Xcode/CLI tool versions,
authorized simulator/CoreDevice availability, connected iPhone state, signing
readiness without secrets, current branch/commit/tree, generated-binding drift,
Mac CLI/iOS build feasibility, free capacity, time synchronization, collector
commands, and current N3/N4 identity-preservation constraints. Do not build a
runtime candidate until both lanes acknowledge one. Result may correctly be
`BLOCKED` on CoreDevice host access, signing, device presence, v0.5 delivery
repair, or candidate freeze.

#### AW4N-WINDOWS-PREFLIGHT — N1/N2 reciprocal readiness manifest

State: `FAN OUT NOW` as a CTO handoff; role `EVIDENCE`; Apple tracked paths:
none. Request through `CAO_TO_CTO.md` (or the current temporary packet until
`COORD-AW-1` merges). Windows captures authoritative branch/commit/tree,
Windows CLI and Pixel artifact feasibility, Android signing lineage, device/
ADB state, disk/build serialization, logcat capacity, clocks, collector
survival, identity-preserving update path, and full Windows gate status. It
returns the exact response record and manifest hash through `CTO_TO_CAO.md`.

#### AW4N-CONTRACT-VALIDATE

State: `FAN OUT NOW` after the two preflight artifacts exist; role `VALIDATOR`;
tracked paths: none. Verify both manifests use the same contract and expose
every blocker without claiming a candidate. Return the minimum readiness list
and whether a four-node window can be scheduled. No implementation.

Full `AW4N-APPLE-CAPTURE`, `AW4N-WINDOWS-CAPTURE`, integrated `AW4N-SCORER`,
and critical review packets wait for v0.5 code acceptance, dual candidate ACK,
four nodes online, synchronized UTC window, and collector preflight.

## 12. Bilateral whole-repository advisory protocol

The same stable journals carry whole-repository recommendations in both
directions. This is advisory and acknowledgment authority, not cross-lane file
ownership: CAO may recommend Windows/Android/core work to CTO; CTO may recommend
iOS/macOS work to CAO; the target lane plans and implements its own paths.

### 12.1 Advisory record schema

Every item has an immutable ID assigned by its origin:

```text
ADV-CAO-CTO-<YYYYMMDD>-<three-digit-sequence>
ADV-CTO-CAO-<YYYYMMDD>-<three-digit-sequence>
```

Every event for that ID records all fields below. `N/A` is explicit; fields are
not omitted.

```text
item_id
event_sequence
event_type: RECOMMEND | REQUEST | ACK | DISPOSITION | APPROVAL | INVALIDATE | CLOSE
origin_lane
target_lane
created_utc
release_scope
classification: APPLE | ANDROID | WINDOWS | DOCS | BUILD | CORE_RUST | SECURITY | RELEASE
origin_branch
origin_source_commit_full_sha
target_branch
target_source_commit_full_sha
coordination_record_commit_full_sha
scope_paths_complete
problem_or_recommendation
acceptance_criteria
evidence_refs_complete_with_sha256
risk_and_cross_platform_impact
required_reviews_and_gates
requested_owner_and_due_condition
disposition: OPEN | RECEIVED | ACCEPTED | DECLINED | DEFERRED | BLOCKED | SUPERSEDED | CLOSED
disposition_reason
acknowledges_item_and_record_commit
supersedes_event_sequence
next_action
```

The origin record includes its source branch/commit; the target ACK records the
exact git commit that carried the origin event. The derived index records both
coordination commits after observation. This avoids impossible self-referential
commit fields while still pinning every recommendation and response to exact
git history.

### 12.2 Reciprocal obligations

- Each controller polls both journals using section 11.7. A target appends
  `RECEIVED` even when it cannot yet decide; no item disappears into chat.
- The target returns `ACCEPTED`, `DECLINED`, `DEFERRED`, or `BLOCKED` with
  evidence and rationale. Acceptance names an owner, source branch/commit,
  exact paths, tests, and review gates. Decline/defer does not erase the item.
- The origin appends `ACK` of the disposition. Closure requires reciprocal ACK
  of the exact disposition record and evidence hashes. Counterproposals are
  new events; materially new scope is a new item ID.
- Each lane writes only its outbound journal. The Windows controller owns the
  derived index, so concurrent recommendations do not collide in one file.
- An advisory cannot authorize an architecture, privacy/security tradeoff,
  API break, release timing/version, account action, merge, or cross-lane edit.
  Those retain their operator and repository gates.
- Before a PR touching one platform merges, the owning controller checks for
  open advisories whose complete scoped paths overlap the PR. It either
  resolves them or records why they do not apply to that exact commit.

### 12.3 Additional prerequisite for all Rust/core changes

For any change to Rust/core, including `core/`, `desktop_bridge/`, CLI-facing
Rust API behavior, generated binding inputs, or Cargo dependency/feature
changes, integration requires both of these exact-commit events:

1. CTO `APPROVAL` of the bounded implementation, authoritative Windows gates,
   and Windows/Android/runtime impact.
2. CAO `APPROVAL` of Apple API/binding/behavior/distribution impact or an
   explicit statement that the reviewed diff has none.

Both approvals pin the full source commit, complete path list, and scoped diff
SHA-256. Any source/dependency/build-input change invalidates both and requires
fresh review. Dual CAO/CTO approval is an additional prerequisite only. It
never replaces:

- operator decision for architecture, security/privacy tradeoff, API-contract
  break, or release timing/versioning;
- mandatory independent adversarial/security review for changes under
  `core/src/{crypto,transport,routing,privacy}/` and any other consequential
  security surface;
- Windows-authoritative build/test/clippy/fmt and Android/physical Pixel gates;
- generated-binding regeneration and Apple Xcode verification when the FFI
  surface changes;
- independent delivery/receipt/custody/retry critical review; or
- Windows orchestrator merge/tag/release authority.

An absent approval, stale commit, unresolved critical finding, or failed gate
is `BLOCKED`. Neither title nor lane may self-approve both sides.

### 12.4 Dispatchable advisory-doc packet

`COORD-AW-1` owns the advisory schema as well as the four-node contract and is
immediately dispatchable. Its validator must seed one non-functional example in
each journal using clearly marked `EXAMPLE-NOT-ACTIVE` IDs, verify immutable-ID
search across a synthetic merged-branch history, and confirm the index can be
rebuilt from the two journals without loss or API pagination. The examples
must not name fake runtime evidence or imply approval.

## 13. Safe branch, commit, push, and PR cadence

1. Controller reads the live queue and main SHA, records blockers, and creates
   one repo-local worktree per packet under
   `tmp/orchestration/worktrees/<PACKET>`. Never reshape or clean the shared
   checkout.
2. Each source branch is `gpt/<bounded-name>`, based on a controller-recorded
   main SHA or an accepted predecessor work-ahead commit. Dependencies may use
   a stacked draft PR with the predecessor's exact head as base; this does not
   authorize changing or merging that base. A writer owns only its packet
   paths and is told other agents are active. No worker touches HANDOFF state,
   core/Rust, generated bindings, or unrelated dirty files.
3. One concern per commit, normally source+its direct tests. Stage explicit
   paths only; never `git commit -a`. Run the packet profile and full finalizer
   before the commit. Delivery/privacy/transport commits also require their
   independent critical review artifact before push.
4. Before the outward-facing push, the Mac controller asks "unless there is a
   reason not to?" and checks complete scoped diff, base, generated drift,
   secrets, tests, reviews, branch name, and absence of gated paths. Push only
   the Mac lane's own fast-forward `gpt/*` branch; never force-push or delete a
   remote branch.
5. Open a draft PR immediately with exact acceptance checklist, Xcode version,
   commands/results, `xcresult`/physical evidence links, owned paths, and all
   known blockers. Mark ready only after reviews. The Windows orchestrator
   alone runs `scripts/pr_scope.sh <PR>` with complete output, merges to main,
   moves HANDOFF tickets, tags, or releases.
6. Rebase is destructive under repository rules and is not used casually. For
   a stale branch, create a fresh worktree/branch from the new approved SHA and
   apply the already reviewed bounded commit forward; rerun every gate.
7. After an accepted predecessor review, a dependent work-ahead packet may
   start from that exact reviewed commit and open a clearly labeled stacked
   draft PR. Main integration still waits. The operator's current directive
   authorizes retaining these named bounded PR branches while the freeze is
   active; keep status/blockers current and never turn them into a hidden
   integration branch. When main integration resumes, create a fresh
   forward-applied branch if necessary and rerun all gates. Close branches only
   through the authorized GitHub lifecycle; no force deletion.

## 14. Dispatch recommendation

### Fan out immediately

- `COORD-AW-1` on its docs-only branch, followed by reciprocal CTO
  acknowledgment.
- `AW4N-APPLE-PREFLIGHT` and the request for
  `AW4N-WINDOWS-PREFLIGHT`; neither selects or builds a candidate.
- `AW4N-CONTRACT-VALIDATE` as soon as both preflight artifacts exist.
- `IOS-V050-1-SO` in the already-scoped delivery worktree; no duplicate writer.
- `IOS-V1-BLE-SCAN`.
- `IOS-V1-BACKUP-SCAN`.
- `IOS-V1-NOTIFY-SCAN`.
- `IOS-V1-RELEASE-SCAN`.
- `MAC-V1-KMP-SCAN` after one of the scan slots frees; there are four total
  collaboration slots including the controller, so keep the controller free
  and run at most three child tasks simultaneously.
- Windows handoff creation for `XLAN-DOCSYNC-0`, `AND-V050-1/2/3`,
  `XLAN-DESKTOP-API`, and `XLAN-MEETING-DESIGN`; Windows decides its own
  serialization and commits.

### Must wait

- Full four-node capture/scoring waits for accepted v0.5 delivery/UI code,
  reciprocal acknowledgment of the same runtime/artifact hashes, healthy
  collectors, all four endpoints, and a synchronized window. The four-node
  pass remains a hard v0.4/v0.5 bilateral gate and does not replace the cloud
  node's five-node custody gate.
- `APPLE-GOV-0` is satisfied for isolated work-ahead branches/PRs. Main merge,
  version/tag/release changes, and HANDOFF ticket movement remain frozen; every
  commit still waits for `XLAN-DOCSYNC-0` and its packet reviews.
- `IOS-V050-1-R2` waits for second opinion and repair plan; `IOS-V050-2/3`
  remain serial behind it.
- UI quality/localization packets wait for the v0.5 UI cut to avoid
  `MainTabView`, Settings, catalog, and project-file conflicts.
- BLE/backup implementation waits for scanner, critical review direction, and
  required operator decisions.
- URL ingress, app sharing, Meeting Mode, entitlements, signing, compliance,
  TestFlight, and notarization wait for explicit product/security/account
  gates.
- KMP functional UI waits for the Windows-owned desktop API and regenerated
  Kotlin bindings. A disconnected preview shell is not useful work-ahead.
- Final XCFramework/bindings freeze waits for the canonical post-PQC core SHA;
  do not repeatedly regenerate committed outputs around moving core.

## 15. Release verdict rule

No single Apple PR, simulator run, or TestFlight upload can establish v1.0.0.
The Apple controller may report a bounded packet as complete only after its
owned behavior, review, and named evidence pass. The Windows orchestrator owns
the cross-platform release verdict after complete Apple evidence, authoritative
Windows/Android gates, core adversarial reviews, same-SHA provenance, and all
required farm drills. Any missing hardware, account, legal answer, Apple
processing result, or cross-lane API is `BLOCKED`, not "passed with a waiver"
unless the operator records an explicit release decision.

---ORCHESTRATION_METADATA---
RESULT: DONE
ROLE: PLANNER
TASK: APPLE-V1-PROGRAM
FILES: ["tmp/orchestration/plans/APPLE-V1-PROGRAM.md"]
VERIFICATION: CONTAINER(read-only repository/source/governance review; python3 scripts/orchestration_contract.py; xcode-select -p; xcodebuild -version; simulator/device services unavailable in sandbox)
SPEC_STATUS: SATISFIED
ESCALATION: OPERATOR
NOTES: ["The operator authorized implementation and upload only on isolated gpt/* work-ahead branches/PRs; the mainline freeze, merges, versions, tags, releases, and HANDOFF moves remain unaffected.", "Do not duplicate IOS-V050-1; it is blocked on SECOND_OPINION after critical review.", "The immutable four-node bilateral gate and reciprocal CAO/CTO journals are hard v0.4/v0.5 coordination requirements.", "Every Rust/core change additionally needs exact-commit CAO and CTO approval; this never replaces operator, adversarial/security, generated-binding, or authoritative Windows gates.", "Apple Developer, hardware, privacy/legal, backup migration, URL/install channel, and Meeting architecture remain explicit human gates.", "Core/Rust implementation, generated bindings, main merges, tags, HANDOFF movement, and release verdict remain Windows-orchestrator owned."]
---END---
