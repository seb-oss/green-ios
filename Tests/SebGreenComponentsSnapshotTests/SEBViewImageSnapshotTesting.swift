import XCTest
import UIKit

/// SEBViewImageSnapshotTesting
///
/// Centralized base class for snapshot tests to:
/// - Provide a single source of truth for snapshot recording mode
/// - Enforce CI destination (device + OS) consistency
/// - Allow developers to record/preview on any simulator locally
///
/// Policy
/// - CI and committed snapshots must be captured and verified on: iPhone 17 Pro (iOS 26.1)
/// - Developers may iterate locally on any simulator when recording is enabled
/// - When not recording and destination mismatches, tests fail with guidance and are skipped
///
/// Usage
/// - Subclass this type instead of XCTestCase in your snapshot suites
/// - Pass `record: Self.snapshotRecordMode` to `assertSnapshot` calls
/// - Optionally set environment variable `SNAPSHOT_RECORD=1` to enable recording without code changes
open class SEBViewImageSnapshotTesting: XCTestCase {
    // MARK: - Configuration

    /// Name of the required simulator device for CI and committed snapshots
    public static let requiredDeviceName: String = "iPhone 17 Pro"

    /// Required iOS version prefix for CI and committed snapshots
    /// Using a prefix allows minor/patch variations (e.g., 26.1.1)
    public static let requiredOSVersionPrefix: String = "26.1"

    /// Global record mode for snapshot tests.
    /// Preferred to toggle via environment variable `SNAPSHOT_RECORD=1` to avoid code churn.
    public static var snapshotRecordMode: Bool {
        ProcessInfo.processInfo.environment["SNAPSHOT_RECORD"] == "1"
    }

    // MARK: - XCTest Lifecycle

    open override func setUp() throws {
        try super.setUpWithError()
        try enforceCIDestinationPolicy(isRecording: Self.snapshotRecordMode)
    }

    // MARK: - Enforcement

    /// Enforces that snapshot tests run on the agreed simulator when not recording.
    /// Allows any destination while recording so developers can preview visuals.
    public func enforceCIDestinationPolicy(isRecording: Bool, file: StaticString = #filePath, line: UInt = #line) throws {
        let env = ProcessInfo.processInfo.environment
        let deviceName = env["SIMULATOR_DEVICE_NAME"] ?? UIDevice.current.name
        let osVersion = UIDevice.current.systemVersion

        if isRecording {
            // Log guidance for developers when recording on a non-CI destination
            let message = "Recording snapshots on \(deviceName) (iOS \(osVersion)). CI expects \(Self.requiredDeviceName) (\(Self.requiredOSVersionPrefix)).\nThis is fine for local iteration, but please switch to the CI destination before committing recordings."
            let attachment = XCTAttachment(string: message)
            attachment.lifetime = .keepAlways
            add(attachment)
            return
        }

        let isCorrectDevice = (deviceName == Self.requiredDeviceName)
        let isCorrectOS = osVersion.hasPrefix(Self.requiredOSVersionPrefix)

        if !(isCorrectDevice && isCorrectOS) {
            let guidance = "Snapshot tests must run on \(Self.requiredDeviceName) (\(Self.requiredOSVersionPrefix)).\nCurrent: \(deviceName) (iOS \(osVersion)).\nDevelopers may record/preview on any simulator by enabling recording (SNAPSHOT_RECORD=1), but verification must target the CI destination to avoid false diffs."
            XCTFail(guidance, file: file, line: line)
            // Skip remaining test execution to avoid generating misleading failures/artifacts
            throw XCTSkip(guidance)
        }
    }
}
