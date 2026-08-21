# Apple v1 CAO continuity v2

Status: Continuity evidence; blocked items remain blocked; no release-readiness claim.
Last updated: 2026-08-21 HST
Known main snapshot: `4830305002f38b000f020cfaf0bb2bac41f3f7cc`, verified at `2026-08-21T08:08:17Z`; this is not a live-current assertion. Blocked commit `b02ec7d9d33eb85c135182c30ee2f797f4f5bd8c` is history-only and never-push.

## Governance and immutable cursors

Read `AGENTS.md`, `HANDOFF/CTO_STATE.md`, `docs/ORCHESTRATION.md`, `orchestration/manifest.yaml`, durable nonterminal task state, and the six continuity documents before acting. Poll history and immutable IDs at controller-turn start and end and at least every 15 minutes during live coordination; honor the CTO packet's 20-minute watch commitment. Branch names are locators, not cursors. Fetch normally before integration; if current main drifted, abandon this integration and fresh-forward-apply reviewed bytes. Never rebase.

Windows cursors: inbound `3289fa5d...`; PR #202 merged at `4830305...` and branch deleted; PR #203 content commit `9279f97d...`, last locally observed head `bcfa931d...`, open/mergeable with mixed check rerun at `2026-08-21T08:08:17Z`. Require a full fresh uncapped check rollup before using any cursor. Candidate manifest `41d6c1fa43ebc9362aa853c0d653e3cb7062137b5452b9e76709cd47ddc4b2d6` on base `4830305...` is unreviewed and absent here; its four documents remain `PENDING-SEPARATE-REVIEWED-BRANCH`.

## Independent evidence gates

The v0.4/v0.5 four-node gate requires Windows CLI, Pixel 6a, macOS CLI, and a physical iPhone on one immutable runtime. The separate mandatory five-node cloud-node custody gate is also required where the release plan requires it. Neither replaces, satisfies, waives, or supplies evidence for the other. Every participant is a node and each node performs store-and-forward custody.

Physical iPhone/Android and iPhone/iPhone evidence must cover dual-service mDNS where applicable, BLE cross-platform delivery, receipt truth, restart persistence, and route-loss recovery. Multipeer is an iOS-to-iOS assist, never a substitute for Android interoperability. Simulator, unit-test, build, and CI results cannot prove physical evidence.

## Finalization blocker

`bash scripts/docs_sync_check.sh` currently fails on the baseline link from `docs/V0.2.0_RESIDUAL_RISK_REGISTER.md` to absent Android test `DiagnosticsBundleFormatterTest.kt`. `XLAN-DOCSYNC-0` is a Windows-owned finalization dependency, not waived. A release reviewer must block commit/push while repository rules require green docs-sync. Do not edit the unrelated documentation merely to clear it.

## Platform deficiencies and required authority

| Area | Deficiency | Owner and gate |
| --- | --- | --- |
| Android | Request enumeration is destructive; failed delivery/manual retry is hidden; mDNS permission/test fidelity is incomplete; shared finite abandonment remains in Android/core; contact recovery writes PeerID bytes as a public-key placeholder. | Windows/core owns correction. Core changes require CAO/CTO/security/operator gates; bindings regenerate under Windows authority. |
| iOS delivery/request | Rejected patches `fc9e5f8afb0960c3c71bf7720522840d716420fb227239caf70ddc1b7da2055a` and `5ffa3a73e260d1df8f6aa10b2713b12788ba84449a3aaf4cfead6d75d02d0c23` are nonapproval. Six first-attempt blockers do not grant release approval; five current blockers remain. | Fresh planner, isolated forward-applied implementation, patch-bound CRITICAL_VALIDATOR, SECOND_OPINION, and RELEASE_GATEKEEPER. `IOS-V050-2` stays blocked. |
| macOS | No macOS/Catalyst app target or selected product/stack; console/Linux KMP skeleton; missing desktop bridge message/contact/history/delivery APIs; non-Linux notification and BLE stubs; scan-only behavior with no GATT central/peripheral and no delivered-message proof. | GUI requires operator decision; read-only architecture comparison is safe. Windows owns bridge/API/FFI decisions. |
| Apple test and CI | Simulator/device-service availability is environment-bound, not physical proof; no UI-test target; notification/background tests are vacuous or simulated; verify script lacks XCTest and warning failure and uses system tmp; CI path omissions; no UI/accessibility, physical farm, archive/export, TestFlight upload, or notarized macOS job. | Signing/distribution remains operator/account/hardware gated. |
| Core/FFI | Durable marker authority, moderation behavior, history-before-network, and bounded persistence can require shared-contract decisions. | Stop and escalate architecture, storage, privacy/security, API/FFI, and product decisions. |

## IOS-V050-1 repair chronology

The first rejected attempt had finite attempt-12 abandonment, actor-reentrant whole-snapshot overwrite, suppressed request-marker persistence errors, unexercised consequential paths, acknowledged-without-receipt age cutoff, and moderation uncertainty. Generic-device build and 62/62 iPhone 17 Pro iOS Simulator 26.5 are nonapproval evidence only.

The replacement critical review blocks: same-item opportunity promotion can discard ACK/terminal truth; the real rejection marker cannot expose flush failure; moderation failure can expose pending peers in the normal inbox and hide its error; initial send suppresses history persistence failure before outbox/network acceptance; and full-array per-item MainActor transactions make quadratic storage work for indefinitely retained obligations. Required evidence is controlled transient/ACK/terminal/receipt races, corrupt-read and terminal-commit-failure no-overwrite tests, real marker/restart/unblock proof, reachable request/inbox failure behavior, production send-history failure, and planner-approved large-queue load/soak behavior.

Rejected worktree/patch locators are ephemeral evidence, not cherry-pick or rebase sources. `IOS_V050_1_REPAIR_2_PLAN_STATUS_CONTINUITY_2026-08-21.md` carries exact fresh-planner redispatch requirements. `IOS-V050-2` depends on accepted repair planning and the forward-applied implementation; do not dispatch a duplicate writer.

## v0.5 through v1.0 workstream table

| Workstream | Status | Required next evidence or authority |
| --- | --- | --- |
| IOS-V050-1-R2 | BLOCKED | Fresh planner, five-blocker design, Windows/core split if needed, three independent reviews. |
| IOS-V050-2 and IOS-V050-3 | WAIT | Accepted R2, then reachable UI work and physical cross-platform proof. |
| APPLE-050-CUT | WAIT | Independent four-node and five-node cloud-node custody gates; Android handoffs closed or explicitly blocked. |
| iOS truth/accessibility/localization | WAIT | Reachable UI, no simulated production claims, XCTest/UI/accessibility and physical evidence. |
| BLE, backup, notification, release scans | SCAN/WAIT | Fresh scoped scans and approved follow-on packets. |
| macOS GUI | OPERATOR_REQUIRED | Product/stack decision and Windows bridge/API direction. |
| archive/TestFlight/notarization | WAIT | Account, signing, assets, compliance, archive/export, and physical evidence. |
| docs finalization | BLOCKED | Windows clears `XLAN-DOCSYNC-0`; release review sees green docs-sync. |

## Resume checklist

1. Re-read governance and all six continuity documents; rebuild state from durable records, not chat.
2. Poll immutable cursors, fetch current main under normal authority, and stop this integration if main changed.
3. Retain blocked evidence; never push `b02ec7d9...` or either rejected iOS patch.
4. Dispatch fresh `IOS-V050-1-REPAIR-2` planning under its exact status-document requirements.
5. Route core, FFI, security/privacy, storage, API, and product choices to authorized Windows/CAO/CTO/security/operator decision paths.
6. After accepted planning, dispatch isolated forward-applied work and bind the three fresh delivery reviewers to its exact patch.
7. Re-run Apple preflight and authoritative Xcode/device gates without calling unavailable simulator/device services absent hardware.
8. Collect distinct immutable four-node and five-node cloud-node custody evidence with Windows, Pixel, Apple, core, and FFI ownership.
9. Obtain a macOS operator product/stack decision before GUI work.
10. Keep `XLAN-DOCSYNC-0` and every unresolved review blocking; no release, tag, merge, or readiness approval exists.
