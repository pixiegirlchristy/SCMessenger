import XCTest
@testable import SCMessenger

@MainActor
final class OutboxRetryPolicyTests: XCTestCase {
    func testInitialReceiptWindowMatchesAndroidParity() {
        XCTAssertEqual(MeshRepository.initialReceiptAwaitSeconds, 60)
    }

    func testAcknowledgedReceiptRetryScheduleMatchesAndroidParity() {
        XCTAssertEqual(MeshRepository.receiptRetryDelaySeconds(ackedWithoutReceiptCount: 1), 60)
        XCTAssertEqual(MeshRepository.receiptRetryDelaySeconds(ackedWithoutReceiptCount: 3), 60)
        XCTAssertEqual(MeshRepository.receiptRetryDelaySeconds(ackedWithoutReceiptCount: 4), 30)
        XCTAssertEqual(MeshRepository.receiptRetryDelaySeconds(ackedWithoutReceiptCount: 8), 30)
        XCTAssertEqual(MeshRepository.receiptRetryDelaySeconds(ackedWithoutReceiptCount: 9), 120)
    }

    func testTransportSettingsPersistWithoutLiveActionsWhenServiceIsStopped() {
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: false,
                previousBleEnabled: true,
                nextBleEnabled: false,
                previousInternetEnabled: true,
                nextInternetEnabled: false
            ),
            []
        )
    }

    func testTransportSettingsPlanOnlyChangedSupportedTransports() {
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: true,
                previousBleEnabled: true,
                nextBleEnabled: false,
                previousInternetEnabled: false,
                nextInternetEnabled: true
            ),
            [.stopBle, .startInternet]
        )
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: true,
                previousBleEnabled: false,
                nextBleEnabled: true,
                previousInternetEnabled: true,
                nextInternetEnabled: false
            ),
            [.startBle, .stopInternet]
        )
    }

    func testTransportSettingsPlanIsEmptyWhenSupportedValuesAreUnchanged() {
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: true,
                previousBleEnabled: true,
                nextBleEnabled: true,
                previousInternetEnabled: false,
                nextInternetEnabled: false
            ),
            []
        )
    }

    func testInternetOnOffOnPlansAStopThenFreshStart() {
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: true,
                previousBleEnabled: true,
                nextBleEnabled: true,
                previousInternetEnabled: true,
                nextInternetEnabled: false
            ),
            [.stopInternet]
        )
        XCTAssertEqual(
            MeshRepository.liveTransportActions(
                serviceRunning: true,
                previousBleEnabled: true,
                nextBleEnabled: true,
                previousInternetEnabled: false,
                nextInternetEnabled: true
            ),
            [.startInternet]
        )
    }

    func testAckedWithoutReceiptStopsAtPatientAgeCeiling() {
        XCTAssertTrue(
            MeshRepository.shouldStopAckedWithoutReceiptRetries(
                ackedWithoutReceiptCount: 1,
                createdAtEpochSec: 100,
                nowEpochSec: 100 + (7 * 24 * 60 * 60),
                maxAgeSeconds: 7 * 24 * 60 * 60
            )
        )
    }

    func testAckedWithoutReceiptContinuesBeforeAgeCeiling() {
        XCTAssertFalse(
            MeshRepository.shouldStopAckedWithoutReceiptRetries(
                ackedWithoutReceiptCount: 50,
                createdAtEpochSec: 100,
                nowEpochSec: 100 + (7 * 24 * 60 * 60) - 1,
                maxAgeSeconds: 7 * 24 * 60 * 60
            )
        )
    }

    func testGenuineFailureDoesNotUseAckAgeCeiling() {
        XCTAssertFalse(
            MeshRepository.shouldStopAckedWithoutReceiptRetries(
                ackedWithoutReceiptCount: 0,
                createdAtEpochSec: 100,
                nowEpochSec: 100 + (30 * 24 * 60 * 60),
                maxAgeSeconds: 7 * 24 * 60 * 60
            )
        )
    }

    func testOutboundPresentationDistinguishesPendingAckAndReceipt() {
        let now: UInt64 = 1_000

        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: false,
                nowEpochSec: now
            ),
            .queued
        )
        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: true,
                nextAttemptAtEpochSec: now + 10,
                nowEpochSec: now
            ),
            .stored
        )
        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: true,
                nextAttemptAtEpochSec: now,
                nowEpochSec: now
            ),
            .forwarding
        )
        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: true,
                nextAttemptAtEpochSec: now + 60,
                nowEpochSec: now,
                ackedWithoutReceiptCount: 1
            ),
            .sent
        )
        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: true,
                messageStatus: .sent,
                hasPendingEnvelope: false,
                nowEpochSec: now
            ),
            .delivered
        )
    }

    func testAutomaticExhaustionIsRetryableButIdentityRejectionIsNot() {
        let now: UInt64 = 1_000

        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: true,
                nowEpochSec: now,
                automaticRetryExhausted: true
            ),
            .failedRetryable
        )
        XCTAssertTrue(
            MeshRepository.canManuallyRetry(
                automaticRetryExhausted: true,
                terminalFailureCode: nil
            )
        )
        XCTAssertEqual(
            MeshRepository.outboundDeliveryState(
                messageDelivered: false,
                messageStatus: .queued,
                hasPendingEnvelope: true,
                nowEpochSec: now,
                automaticRetryExhausted: true,
                terminalFailureCode: "identity_device_mismatch"
            ),
            .rejectedNonretryable
        )
        XCTAssertFalse(
            MeshRepository.canManuallyRetry(
                automaticRetryExhausted: true,
                terminalFailureCode: "identity_device_mismatch"
            )
        )
    }

    func testManualRetryResetsTheExistingEnvelopeWithoutChangingHistoryIdentity() {
        let original = MeshRepository.PendingOutboundEnvelope(
            queueId: "queue-id",
            historyRecordId: "history-id",
            peerId: "peer-id",
            routePeerId: "route-id",
            addresses: ["/ip4/127.0.0.1/tcp/9001"],
            envelopeBase64: "encrypted-envelope",
            createdAtEpochSec: 100,
            attemptCount: 12,
            nextAttemptAtEpochSec: 200,
            strictBleOnlyMode: false,
            recipientIdentityId: "identity-id",
            intendedDeviceId: "device-id",
            terminalFailureCode: nil,
            ackedWithoutReceiptCount: 0,
            automaticRetryExhausted: true
        )

        let retried = original.resettingForManualRetry(at: 1_000)

        XCTAssertEqual(retried.queueId, original.queueId)
        XCTAssertEqual(retried.historyRecordId, original.historyRecordId)
        XCTAssertEqual(retried.envelopeBase64, original.envelopeBase64)
        XCTAssertEqual(retried.attemptCount, 0)
        XCTAssertEqual(retried.nextAttemptAtEpochSec, 1_000)
        XCTAssertNil(retried.automaticRetryExhausted)
    }
}
