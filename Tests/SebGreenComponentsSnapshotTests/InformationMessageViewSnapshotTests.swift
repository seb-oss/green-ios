//
//  InformationMessageViewSnapshotTests.swift
//  SebGreenComponents
//

import SwiftUI
import XCTest
@testable import SebGreenComponents

final class InformationMessageViewSnapshotTests: SEBViewImageSnapshotTesting {
    func test_InformationMessageView_information() {
        messageView(variant: .information, actions: .init(onClose: {}))
            .snapshotTest()
    }

    func test_InformationMessageView_notice_ctaInternal() {
        messageView(
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

    func test_InformationMessageView_warning_ctaExternal() {
        messageView(
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

    func test_InformationMessageView_error() {
        messageView(variant: .error, actions: .init(onClose: {}))
            .snapshotTest()
    }

    private func messageView(
        variant: InformationMessageView.Variant,
        actions: InformationMessageView.Actions
    ) -> some View {
        InformationMessageView(
            model: .init(
                title: title(for: variant),
                message: message(for: variant),
                variant: variant
            ),
            actions: actions
        )
    }

    private func title(for variant: InformationMessageView.Variant) -> String {
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

    private func message(for variant: InformationMessageView.Variant) -> String {
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
