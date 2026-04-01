//
//  AlertSnapshotTests.swift
//  SebGreenComponents
//

import SwiftUI
import XCTest
@testable import SebGreenComponents

final class CommunicationBannerSnapshotTests: SEBViewImageSnapshotTesting {
    func test_InformationMessageView_information() {
        banner(variant: .information, actions: .init(onClose: {}))
            .snapshotTest()
    }

    func test_InformationMessageView_notice_ctaInternal() {
        banner(
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
        banner(
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
        banner(variant: .error, actions: .init(onClose: {}))
            .snapshotTest()
    }

    private func banner(
        variant: CommunicationBanner.Variant,
        actions: CommunicationBanner.Actions
    ) -> some View {
        CommunicationBanner(
            model: .init(
                title: title(for: variant),
                message: message(for: variant),
                variant: variant
            ),
            actions: actions
        )
    }

    private func title(for variant: CommunicationBanner.Variant) -> String {
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

    private func message(for variant: CommunicationBanner.Variant) -> String {
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
