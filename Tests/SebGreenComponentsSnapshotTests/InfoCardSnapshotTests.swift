//
//  InfoCardSnapshotTests.swift
//  SebGreenComponents
//
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class InfoCardPreviewSnapshotTests: XCTestCase {
    private static let recordSnapshots = false
    
    // MARK: - Information
    
    func test_InfoCard_information_close() {
        assertOnAllDevices(
            name: "information_close",
            view: infoCard(variant: .information, actions: .init(onClose: {})),
            record: Self.recordSnapshots
        )
    }
    
    func test_InfoCard_information_closeAndCTA() {
        assertOnAllDevices(
            name: "information_closeAndCTA",
            view: infoCard(
                variant: .information,
                actions: .init(
                    onClose: {},
                    callToAction: .init(title: "Spärra kort", action: {})
                )
            ),
            record: Self.recordSnapshots
        )
    }
    
    func test_InfoCard_information_tap() {
        assertOnAllDevices(
            name: "information_tap",
            view: infoCard(variant: .information, actions: .init(onTap: {})),
            record: Self.recordSnapshots
        )
    }
    
    // MARK: - InformationHd
    
    func test_InfoCard_informationHd_close() {
        assertOnAllDevices(
            name: "informationHd_close",
            view: infoCard(variant: .informationHd, actions: .init(onClose: {})),
            record: Self.recordSnapshots
        )
    }
    
    func test_InfoCard_informationHd_closeAndCTA() {
        assertOnAllDevices(
            name: "informationHd_closeAndCTA",
            view: infoCard(
                variant: .informationHd,
                actions: .init(
                    onClose: {},
                    callToAction: .init(title: "Spärra kort", action: {})
                )
            ),
            record: Self.recordSnapshots
        )
    }
    
    func test_InfoCard_informationHd_tap() {
        assertOnAllDevices(
            name: "informationHd_tap",
            view: infoCard(variant: .informationHd, actions: .init(onTap: {})),
            record: Self.recordSnapshots
        )
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
