# IOS-V050-1-REPAIR-2 planning status

Status: PENDING/UNAVAILABLE — FRESH PLANNER REQUIRED
Last updated: 2026-08-21 HST
Authority: This is continuity status, not a plan, implementation approval, or release decision. No repair-2 plan artifact exists because its planner was interrupted for the emergency cutoff. `IOS-V050-2` remains blocked until a fresh plan and a reviewed forward-applied implementation exist.

## Non-approval evidence retained

The first delivery/request patch was rejected at SHA-256 `fc9e5f8afb0960c3c71bf7720522840d716420fb227239caf70ddc1b7da2055a`. The replacement writer patch was rejected at SHA-256 `5ffa3a73e260d1df8f6aa10b2713b12788ba84449a3aaf4cfead6d75d02d0c23`. The generic-device build and 62/62 iPhone 17 Pro, iOS Simulator 26.5 result are regression evidence only; neither approves either patch, proves physical delivery, nor waives a block. Six earlier ordinary-path blockers were reviewed; these five remain.

## Five current critical blockers

1. Same-item opportunity promotion racing an in-flight transport result must preserve receipt/removal as strongest truth, durably retain ACK and terminal identity truth, and prevent stale transient results overwriting newer scheduling mutations.
2. Request rejection needs a production-used, observable crash-durable marker authority and restart/unblock reconciliation. The nonthrowing contact flush is not durable-success evidence.
3. Moderation lookup failure must fail closed at reachable request and main inbox call sites, show an owning-screen error, and show pending peers in neither surface.
4. Initial send needs observable durable history before outbox acceptance or network. History failure must prevent enqueue and transport.
5. Indefinitely retained obligations need bounded-write persistence and a planner-defined large-queue/MainActor latency and write-amplification gate. Capping or deleting accepted obligations is forbidden.

Required evidence includes deterministic corrupt-read/no-overwrite and terminal-commit-failure cases; controlled same-item transient, ACK, terminal, and receipt races; real marker/restart/unblock evidence; reachable inbox failure behavior; production send/history-failure behavior; and load/soak evidence. The planner must remove or justify the dead `snapshot()` and unused `.applied` surfaces.

## Exact fresh-planner redispatch requirements

The fresh read-only planner must read AGENTS/onboard/orchestrate/protocol/manifest, original and repair plans, rejected patch and state, both earlier blocked reviews, the new critical review, the live field contract, and every reachable production/test call site needed to resolve uncertainty. Inspect current upstream/main and classify the complete forward delta from rejected base `5f052764a713a5932b1d99d51bf6c41e8143c477` without rebasing.

The plan must state authoritative behavior invariants and a conflict-resolution lattice; identify exact files, reachable call sites, and explicit per-packet ownership; decide whether each correction remains Apple-only; and, if contact durability requires core/FFI, split a Windows-owned dependent packet requiring exact-commit CAO/CTO approval, operator/security gates, binding regeneration, Windows authority, and Apple Xcode verification.

It must define a dependency DAG and serialized/parallel packets with base selector, worktree/isolation, model/effort, acceptance tests, authoritative Xcode/device gates, and independent reviewer roles. It must reconcile v0.5 request/status UI ownership with `IOS-V050-2` without duplicate writers, state stop/escalation conditions for architecture, storage stack, privacy/security, API/FFI, and product choices without silently selecting a persistent stack or shared contract, and specify forward application onto current main with no rebase, merge, commit, push, PR, tracked-file edit, or core/Rust edit by the planner.

The fresh plan returns its path and SHA-256, complete blockers/dependencies, and canonical planner metadata. Any implementation requires new patch-bound independent `CRITICAL_VALIDATOR`, `SECOND_OPINION`, and `RELEASE_GATEKEEPER` reviews; previous BLOCK reviews cannot approve a new patch.
