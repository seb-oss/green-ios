//
//  InfoCardSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Chakraborty, Sujata on 2026-02-05.
//
import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class InfoCardPreviewSnapshotTests: SEBViewImageSnapshotTesting {

    // MARK: - Information

    func test_InfoCard_information_close() {
        let view = infoCard(
            variant: .information,
            actions: .init(onClose: {})
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    func test_InfoCard_information_closeAndCTA() {
        let view = infoCard(
            variant: .information,
            actions: .init(
                onClose: {},
                callToAction: .init(title: "Spärra kort", action: {})
            )
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    func test_InfoCard_information_tap() {
        let view = infoCard(
            variant: .information,
            actions: .init(onTap: {})
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    // MARK: - InformationHd

    func test_InfoCard_informationHd_close() {
        let view = infoCard(
            variant: .informationHd,
            actions: .init(onClose: {})
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    func test_InfoCard_informationHd_closeAndCTA() {
        let view = infoCard(
            variant: .informationHd,
            actions: .init(
                onClose: {},
                callToAction: .init(title: "Spärra kort", action: {})
            )
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    func test_InfoCard_informationHd_tap() {
        let view = infoCard(
            variant: .informationHd,
            actions: .init(onTap: {})
        )
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.snapshotRecordMode)
    }

    // MARK: - Helpers

    private func infoCard(
        variant: InfoCardView.Variant,
        actions: InfoCardView.Actions
    ) -> some View {
        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: variant
            ),
            actions: actions
        )
        .frame(width: 320, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding()
    }
}
