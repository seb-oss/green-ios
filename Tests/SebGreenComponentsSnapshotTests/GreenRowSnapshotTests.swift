//
//  GreenRowSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-02-20.
//

import SwiftUI
import XCTest
import SnapshotTesting
import GdsKit
@testable import SebGreenComponents

final class GreenRowSnapshotTests: XCTestCase {
    private static let recordSnapshots = false

    // MARK: - list56 gallery
    func test_GreenRow_allStates_list56_light() {
        let view = RowGallery56()
            .frame(width: 375)
            .background(Color.l1Neutral02)

        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            record: Self.recordSnapshots
        )
    }

    func test_GreenRow_allStates_list56_dark() {
        let view = RowGallery56()
            .frame(width: 375)
            .background(Color.l1Neutral02)

        let traits = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits, traits: traits),
            record: Self.recordSnapshots
        )
    }

    // MARK: - list72 gallery
    func test_GreenRow_allStates_list72_light() {
        let view = RowGallery72()
            .frame(width: 375)
            .background(Color.l1Neutral02)

        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Disabled / Selected / No separator
    func test_GreenRow_disabled_selected_and_noSeparator_states() {
        let view = VStack(spacing: 0) {
            GreenRow(
                title: "Selected row",
                leading: .checkbox(isSelected: true),
                trailing: .chevron,
                size: .list56,
                isEnabled: true,
                isSelected: true,
                showsSeparator: true,
                onTap: {}
            )
            GreenRow(
                title: "Disabled row",
                subtitle: "Not available right now",
                leading: .icon(Image(systemName: "lock.fill")),
                size: .list56,
                isEnabled: false,
                showsSeparator: true
            )
            GreenRow(
                title: "No separator",
                subtitle: "Visual grouping without divider",
                trailing: .valueText("Value"),
                size: .list56,
                showsSeparator: false,
                onTap: {}
            )
        }
        .frame(width: 375)
        .background(Color.l1Neutral02)

        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Long text / wrapping + Dynamic Type
    func test_GreenRow_longText_wrapping_dynamicType_AX1() {
        let view = RowLongTextGallery()
            .frame(width: 375)
            .background(Color.l1Neutral02)

        let traits = UITraitCollection(preferredContentSizeCategory: .accessibilityLarge)
        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits, traits: traits),
            record: Self.recordSnapshots
        )
    }
}

// MARK: - Test fixtures / galleries

private struct RowGallery56: View {
    @State private var toggleNotifications = true
    @State private var toggleWifiOnly = false

    var body: some View {
        VStack(spacing: 0) {
            // Title only + chevron
            GreenRow(
                title: "Title only",
                trailing: .chevron,
                size: .list56,
                onTap: {}
            )

            // Leading icon
            GreenRow(
                title: "Leading icon",
                leading: .icon(Image(systemName: "doc.plaintext")),
                size: .list56,
                onTap: {}
            )

            // Leading icon + trailing value
            GreenRow(
                title: "Value text",
                leading: .icon(Image(systemName: "creditcard")),
                trailing: .valueText("1 234 kr"),
                size: .list56,
                onTap: {}
            )

            // Leading icon + trailing icon
            GreenRow(
                title: "Trailing icon",
                leading: .icon(Image(systemName: "person.fill")),
                trailing: .icon(Image(systemName: "info.circle")),
                size: .list56,
                onTap: {}
            )

            // Trailing toggle only
            GreenRow(
                title: "Wi‑Fi only",
                trailing: .toggle(isOn: $toggleWifiOnly),
                size: .list56
            )

            // Leading icon + trailing toggle
            GreenRow(
                title: "Notifications",
                subtitle: "Push and email alerts",
                leading: .icon(Image(systemName: "bell.fill")),
                trailing: .toggle(isOn: $toggleNotifications),
                size: .list56
            )

            // Trailing checkbox
            GreenRow(
                title: "Checkbox trailing",
                trailing: .checkbox(isSelected: true),
                size: .list56,
                isSelected: true
            )

            // Trailing radio
            GreenRow(
                title: "Radio trailing",
                trailing: .radio(isSelected: true),
                size: .list56,
                isSelected: true
            )

            // Disabled compact row
            GreenRow(
                title: "Disabled compact row",
                leading: .icon(Image(systemName: "lock.fill")),
                size: .list56,
                isEnabled: false
            )
        }
    }
}

private struct RowGallery72: View {
    var body: some View {
        VStack(spacing: 0) {
            // Title only + chevron
            GreenRow(
                title: "Title only",
                trailing: .chevron,
                size: .list72,
                onTap: {}
            )

            // Title + subtitle + leading icon
            GreenRow(
                title: "Headline",
                subtitle: "Sub headline",
                leading: .icon(Image(systemName: "doc.plaintext")),
                trailing: .chevron,
                size: .list72,
                onTap: {}
            )

            // Leading icon + trailing value text
            GreenRow(
                title: "With value",
                subtitle: "Summary of the row",
                leading: .icon(Image(systemName: "creditcard")),
                trailing: .valueText("1 234 kr"),
                size: .list72,
                onTap: {}
            )

            // Leading icon + trailing icon
            GreenRow(
                title: "Trailing icon",
                subtitle: "Additional context",
                leading: .icon(Image(systemName: "person.fill")),
                trailing: .icon(Image(systemName: "info.circle")),
                size: .list72,
                onTap: {}
            )

            // Leading checkbox (unchecked)
            GreenRow(
                title: "Checkbox option",
                leading: .checkbox(isSelected: false),
                size: .list72,
                onTap: {}
            )

            // Leading checkbox (selected)
            GreenRow(
                title: "Checkbox selected",
                leading: .checkbox(isSelected: true),
                size: .list72,
                isSelected: true,
                onTap: {}
            )

            // Leading radio (unselected)
            GreenRow(
                title: "Radio option",
                leading: .radio(isSelected: false),
                size: .list72,
                onTap: {}
            )

            // Leading radio (selected)
            GreenRow(
                title: "Radio selected",
                leading: .radio(isSelected: true),
                size: .list72,
                isSelected: true,
                onTap: {}
            )

            // Disabled row
            GreenRow(
                title: "Disabled row",
                subtitle: "Not available right now",
                leading: .icon(Image(systemName: "lock.fill")),
                size: .list72,
                isEnabled: false,
                onTap: {}
            )
        }
    }
}

private struct RowLongTextGallery: View {
    private let longTitle = "Very long title that should wrap across multiple lines to validate typography and spacing in the row component and ensure no clipping occurs in the layout."
    private let longSubtitle = "This is an equally long subtitle intended to demonstrate multiline wrapping behavior for secondary text, verifying line height, spacing, and color in both light and dark modes."

    var body: some View {
        VStack(spacing: 0) {
            GreenRow(
                title: longTitle,
                subtitle: longSubtitle,
                leading: .icon(Image(systemName: "doc.plaintext")),
                trailing: .valueText("1 234 567 kr"),
                size: .list72,
                onTap: {}
            )

            GreenRow(
                title: longTitle,
                trailing: .chevron,
                size: .list56,
                onTap: {}
            )

            GreenRow(
                title: longTitle,
                subtitle: longSubtitle,
                trailing: .icon(Image(systemName: "info.circle")),
                size: .list72,
                onTap: {}
            )
        }
    }
}

