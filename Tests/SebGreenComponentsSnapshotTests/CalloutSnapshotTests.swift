import SwiftUI
import XCTest
@testable import SebGreenComponents

final class CalloutSnapshotTests: SEBViewImageSnapshotTesting {
    func test_callout_information() {
        callout(variant: .information, actions: .init(onClose: {}))
            .snapshotTest()
    }

    func test_callout_notice_ctaInternal() {
        callout(
            variant: .notice,
            actions: .init(
                onClose: {},
                callToAction: .init(
                    title: "See details",
                    linkStyle: .internalLink,
                    action: {}
                )
            )
        )
        .snapshotTest()
    }

    func test_callout_warning_ctaExternal() {
        callout(
            variant: .warning,
            actions: .init(
                callToAction: .init(
                    title: "Read more",
                    linkStyle: .externalLink,
                    action: {}
                )
            )
        )
        .snapshotTest()
    }

    func test_callout_error() {
        callout(variant: .error, actions: .init(onClose: {}))
            .snapshotTest()
    }

    private func callout(
        variant: Callout.Variant,
        actions: Callout.Actions
    ) -> some View {
        Callout(
            model: .init(
                id: "",
                title: title(for: variant),
                shortText: message(for: variant),
                variant: variant,
                actions: actions
            ),
        )
    }

    private func title(for variant: Callout.Variant) -> String {
        switch variant {
        case .information:
            return "Information"
        case .notice:
            return "Notice"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        }
    }

    private func message(for variant: Callout.Variant) -> String {
        switch variant {
        case .information:
            return "Used for passive, non-critical updates like tips or background information."
        case .notice:
            return "Used for actionable, attention-worthy updates that are still non-critical."
        case .warning:
            return "Used to highlight important risks or information without interrupting the flow."
        case .error:
            return "Used to communicate that something has gone wrong and needs user attention."
        }
    }
}
