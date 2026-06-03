import SwiftUI
import XCTest
@testable import SebGreenComponents

final class CalloutSnapshotTests: SEBViewImageSnapshotTesting {

    // MARK: - Variants

    func test_callout_information_subtle() {
        callout(variant: .information(.subtle))
            .snapshotTest()
    }

    func test_callout_information_default() {
        callout(variant: .information(.default))
            .snapshotTest()
    }

    func test_callout_notice() {
        callout(variant: .notice)
            .snapshotTest()
    }

    func test_callout_warning() {
        callout(variant: .warning)
            .snapshotTest()
    }

    func test_callout_critical() {
        callout(variant: .critical)
            .snapshotTest()
    }

    // MARK: - Configurations

    func test_callout_closeButton() {
        callout(variant: .notice, onClose: {})
            .snapshotTest()
    }

    func test_callout_cta_internalLink() {
        callout(
            variant: .notice,
            action: .init(title: "See details", linkStyle: .internalLink, action: {})
        )
        .snapshotTest()
    }

    func test_callout_cta_externalLink() {
        callout(
            variant: .warning,
            action: .init(title: "Read more", linkStyle: .externalLink, action: {})
        )
        .snapshotTest()
    }

    func test_callout_alternativeBackground() {
        callout(variant: .information(.subtle), onClose: {})
            .snapshotTest(.neutral01)

        callout(variant: .information(.subtle), onClose: {})
            .snapshotTest(.neutral02)
    }

    // MARK: - Helpers

    private func callout(
        variant: Callout.Variant,
        action: Callout.Action? = nil,
        onClose: (() -> Void)? = nil
    ) -> some View {
        Callout(
            title(for: variant),
            shortText: shortText(for: variant),
            action: action,
            onClose: onClose
        )
        .calloutStyle(variant)
    }

    private func title(for variant: Callout.Variant) -> String {
        switch variant {
        case .information: "Information"
        case .notice: "Notice"
        case .warning: "Warning"
        case .critical: "Critical"
        }
    }

    private func shortText(for variant: Callout.Variant) -> String {
        switch variant {
        case .information: "Used for passive, non-critical updates like tips or background information."
        case .notice: "Used for actionable, attention-worthy updates that are still non-critical."
        case .warning: "Used to highlight important risks or information without interrupting the flow."
        case .critical: "Used to communicate that something has gone wrong and needs user attention."
        }
    }
}
