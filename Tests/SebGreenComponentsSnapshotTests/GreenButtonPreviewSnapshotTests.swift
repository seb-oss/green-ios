//
//  GreenButtonPreviewSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-01-26.
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class GreenButtonPreviewSnapshotTests: XCTestCase {
    override class func setUp() {
        isRecording = false
    }
    
    // MARK: - Text only
    func test_GreenButton_textOnly_brand() {
        let view = GreenButtonPreviewCases.textOnly(kind: .brand)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_textOnly_primary() {
        let view = GreenButtonPreviewCases.textOnly(kind: .primary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_textOnly_secondary() {
        let view = GreenButtonPreviewCases.textOnly(kind: .secondary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_textOnly_tertiary() {
        let view = GreenButtonPreviewCases.textOnly(kind: .tertiary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_textOnly_outline() {
        let view = GreenButtonPreviewCases.textOnly(kind: .outline)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_textOnly_negative() {
        let view = GreenButtonPreviewCases.textOnly(kind: .negative)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    // MARK: - Leading icon
    func test_GreenButton_leadingIcon_brand() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .brand)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_leadingIcon_primary() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .primary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_leadingIcon_secondary() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .secondary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_leadingIcon_tertiary() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .tertiary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_leadingIcon_outline() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .outline)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_leadingIcon_negative() {
        let view = GreenButtonPreviewCases.leadingIcon(kind: .negative)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    // MARK: - Trailing icon
    func test_GreenButton_trailingIcon_brand() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .brand)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_trailingIcon_primary() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .primary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_trailingIcon_secondary() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .secondary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_trailingIcon_tertiary() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .tertiary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_trailingIcon_outline() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .outline)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_trailingIcon_negative() {
        let view = GreenButtonPreviewCases.trailingIcon(kind: .negative)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    // MARK: - Icon only
    func test_GreenButton_iconOnly_brand() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .brand)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_iconOnly_primary() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .primary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_iconOnly_secondary() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .secondary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_iconOnly_tertiary() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .tertiary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_iconOnly_outline() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .outline)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_iconOnly_negative() {
        let view = GreenButtonPreviewCases.iconOnly(kind: .negative)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    // MARK: - Disabled
    func test_GreenButton_disabled_brand() {
        let view = GreenButtonPreviewCases.disabled(kind: .brand)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_disabled_primary() {
        let view = GreenButtonPreviewCases.disabled(kind: .primary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_disabled_secondary() {
        let view = GreenButtonPreviewCases.disabled(kind: .secondary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_disabled_tertiary() {
        let view = GreenButtonPreviewCases.disabled(kind: .tertiary)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_disabled_outline() {
        let view = GreenButtonPreviewCases.disabled(kind: .outline)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func test_GreenButton_disabled_negative() {
        let view = GreenButtonPreviewCases.disabled(kind: .negative)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }
}
