//
//  GreenListSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-02-20.
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class GreenListSnapshotTests: XCTestCase {
    private static let recordSnapshots = false

    // Canvas sizes approximating iPhone portrait safe area
    private let canvasWidth: CGFloat = 375
    private let canvasHeight: CGFloat = 800

    // MARK: - Plain
    func test_GreenList_plain_light() {
        let view = list(style: .plain)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight)),
            record: Self.recordSnapshots
        )
    }

    func test_GreenList_plain_dark() {
        let view = list(style: .plain)
        let traits = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight), traits: traits),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Grouped
    func test_GreenList_grouped_light() {
        let view = list(style: .grouped)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight)),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Elevated
    func test_GreenList_elevated_light() {
        let view = elevatedContainer(style: .elevated)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight)),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Elevated Grouped
    func test_GreenList_elevatedGrouped_light() {
        let view = elevatedContainer(style: .elevatedGrouped)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight)),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Dynamic Type emphasis
    func test_GreenList_grouped_dynamicType_AX3() {
        let view = list(style: .grouped)
        let traits = UITraitCollection(preferredContentSizeCategory: .accessibility3)
        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: canvasWidth, height: canvasHeight), traits: traits),
            record: Self.recordSnapshots
        )
    }

    // MARK: - Helpers

    private func list(style: GreenList<EmptyView>.Style) -> some View {
        GreenList(style: style) {
            ListFixtureContent()
        }
        .background(Color.l1Neutral02)
    }

    private func elevatedContainer(style: GreenList<EmptyView>.Style) -> some View {
        ZStack(alignment: .top) {
            Color.black
                .frame(height: 56)
                .ignoresSafeArea(edges: .top)

            GreenList(style: style) {
                ListFixtureContent()
            }
        }
        .background(Color.l1Neutral02)
    }
}

// MARK: - Fixture content used across list styles

private struct ListFixtureContent: View {
    @State private var toggleOn = true
    @State private var toggleOff = false

    var body: some View {
        Group {
            // Section title mimic
            Text("List Showcase")
                .typography(.detailRegularS)
                .foregroundColor(.contentNeutral03)
                .padding(.horizontal, .spaceM)
                .padding(.top, .spaceS)

            // Rows covering common states
            GreenRow(
                title: "Title only",
                trailing: .chevron,
                onTap: {}
            )

            GreenRow(
                title: "With subtitle",
                subtitle: "Subtitle text",
                leading: .icon(Image(systemName: "doc.plaintext")),
                trailing: .chevron,
                size: .list72,
                onTap: {}
            )

            GreenRow(
                title: "Value text",
                leading: .icon(Image(systemName: "creditcard")),
                trailing: .valueText("1 234 kr"),
                size: .list72,
                onTap: {}
            )

            GreenRow(
                title: "Trailing icon",
                leading: .icon(Image(systemName: "person.fill")),
                trailing: .icon(Image(systemName: "info.circle")),
                onTap: {}
            )

            GreenRow(
                title: "Toggle row",
                leading: .icon(Image(systemName: "bell.fill")),
                trailing: .toggle(isOn: $toggleOn)
            )

            GreenRow(
                title: "Checkbox selected",
                leading: .checkbox(isSelected: true),
                isSelected: true,
                onTap: {}
            )

            GreenRow(
                title: "Radio selected",
                leading: .radio(isSelected: true),
                isSelected: true,
                onTap: {}
            )

            GreenRow(
                title: "Disabled row",
                subtitle: "Not available",
                leading: .icon(Image(systemName: "lock.fill")),
                isEnabled: false,
                showsSeparator: false,
                onTap: {}
            )
        }
    }
}
