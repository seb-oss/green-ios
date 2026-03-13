//
//  GdsToggleSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-03-13.
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class GdsToggleSnapshotTests: SEBViewImageSnapshotTesting {

    func test_Toggle_gdsTint_allStates_light() {
        let view = ToggleGdsTintGallery()
        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            record: Self.snapshotRecordMode
        )
    }

    func test_Toggle_gdsTint_allStates_dark() {
        let view = ToggleGdsTintGallery()
        let traits = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits, traits: traits),
            record: Self.snapshotRecordMode
        )
    }
}

// MARK: - Fixture

private struct ToggleGdsTintGallery: View {
    var body: some View {
        VStack(spacing: .spaceL) {
            // On (enabled)
            Toggle("", isOn: .constant(true))
                .gdsToggleTint()
                .labelsHidden()

            // On (disabled)
            Toggle("", isOn: .constant(true))
                .gdsToggleTint()
                .labelsHidden()
                .disabled(true)

            // Off (enabled)
            Toggle("", isOn: .constant(false))
                .gdsToggleTint()
                .labelsHidden()

            // Off (disabled)
            Toggle("", isOn: .constant(false))
                .gdsToggleTint()
                .labelsHidden()
                .disabled(true)
        }
        .frame(width: 320)
        .padding(.spaceL)
        .background(Color.l1Neutral02)
    }
}
