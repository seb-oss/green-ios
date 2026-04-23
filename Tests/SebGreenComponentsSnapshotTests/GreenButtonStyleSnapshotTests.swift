//
//  GreenButtonStyleSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-01-26.
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class GreenButtonStyleSnapshotTests: SEBViewImageSnapshotTesting {
    
    // MARK: - Helper Methods
    
    /// Creates a button for snapshot testing with consistent configuration
    /// - Parameters:
    ///   - text: The button label text
    ///   - systemImage: Optional SF Symbol name for icon
    ///   - style: The button style to apply
    ///   - isDisabled: Whether the button should be disabled
    /// - Returns: A view ready for snapshot testing
    private func makeButton(
        text: String = "Button",
        systemImage: String? = nil,
        style: GreenButtonStyle,
        isDisabled: Bool = false
    ) -> some View {
        Group {
            if let systemImage {
                Button {
                    // No action needed for snapshot tests
                } label: {
                    Label(text, systemImage: systemImage)
                }
            } else {
                Button(text) {
                    // No action needed for snapshot tests
                }
            }
        }
        .buttonStyle(.seb(style))
        .disabled(isDisabled)
        .padding()
        .frame(width: 320)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    /// Asserts a snapshot of a button view
    private func assertButtonSnapshot(
        of view: some View,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            record: Self.snapshotRecordMode,
            file: file,
            testName: testName,
            line: line
        )
    }
    
    // MARK: - Text Only Tests
    
    func test_SEBGreenButtonStyle_primary_textOnly() {
        let view = makeButton(text: "Primary", style: .primary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_secondary_textOnly() {
        let view = makeButton(text: "Secondary", style: .secondary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_tertiary_textOnly() {
        let view = makeButton(text: "Tertiary", style: .tertiary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_outline_textOnly() {
        let view = makeButton(text: "Outline", style: .outline)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_negative_textOnly() {
        let view = makeButton(text: "Negative", style: .negative)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_notice_textOnly() {
        let view = makeButton(text: "Notice", style: .notice)
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Leading Icon Tests
    
    func test_SEBGreenButtonStyle_primary_leadingIcon() {
        let view = makeButton(text: "Primary", systemImage: "star.fill", style: .primary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_secondary_leadingIcon() {
        let view = makeButton(text: "Secondary", systemImage: "star.fill", style: .secondary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_tertiary_leadingIcon() {
        let view = makeButton(text: "Tertiary", systemImage: "star.fill", style: .tertiary)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_outline_leadingIcon() {
        let view = makeButton(text: "Outline", systemImage: "star.fill", style: .outline)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_negative_leadingIcon() {
        let view = makeButton(text: "Negative", systemImage: "star.fill", style: .negative)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_notice_leadingIcon() {
        let view = makeButton(text: "Notice", systemImage: "star.fill", style: .notice)
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Trailing Icon Tests
    
    func test_SEBGreenButtonStyle_primary_trailingIcon() {
        let view = makeButton(text: "Primary", systemImage: "arrow.right", style: .primary.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_secondary_trailingIcon() {
        let view = makeButton(text: "Secondary", systemImage: "arrow.right", style: .secondary.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_tertiary_trailingIcon() {
        let view = makeButton(text: "Tertiary", systemImage: "arrow.right", style: .tertiary.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_outline_trailingIcon() {
        let view = makeButton(text: "Outline", systemImage: "arrow.right", style: .outline.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_negative_trailingIcon() {
        let view = makeButton(text: "Negative", systemImage: "arrow.right", style: .negative.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_notice_trailingIcon() {
        let view = makeButton(text: "Notice", systemImage: "arrow.right", style: .notice.iconPosition(.trailing))
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Icon Only Tests (Circle Shape)
    
    func test_SEBGreenButtonStyle_primary_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
        // Example: Button with Label containing only icon, .primary(shape: .circle)
    }
    
    func test_SEBGreenButtonStyle_secondary_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
    }
    
    func test_SEBGreenButtonStyle_tertiary_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
    }
    
    func test_SEBGreenButtonStyle_outline_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
    }
    
    func test_SEBGreenButtonStyle_negative_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
    }
    
    func test_SEBGreenButtonStyle_notice_iconOnly() {
        // TODO: Implement icon-only button test with circle shape
    }
    
    // MARK: - Disabled State Tests
    
    func test_SEBGreenButtonStyle_primary_disabled() {
        let view = makeButton(text: "Primary", style: .primary, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_secondary_disabled() {
        let view = makeButton(text: "Secondary", style: .secondary, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_tertiary_disabled() {
        let view = makeButton(text: "Tertiary", style: .tertiary, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_outline_disabled() {
        let view = makeButton(text: "Outline", style: .outline, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_negative_disabled() {
        let view = makeButton(text: "Negative", style: .negative, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_notice_disabled() {
        let view = makeButton(text: "Notice", style: .notice, isDisabled: true)
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Size Variation Tests
    
    func test_SEBGreenButtonStyle_primary_small() {
        let view = makeButton(text: "Small", style: .primary.dimensions(.small))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_primary_medium() {
        let view = makeButton(text: "Medium", style: .primary.dimensions(.medium))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_primary_large() {
        let view = makeButton(text: "Large", style: .primary.dimensions(.large))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_primary_xlarge() {
        let view = makeButton(text: "XLarge", style: .primary.dimensions(.xlarge))
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Layout Behavior Tests
    
    func test_SEBGreenButtonStyle_primary_layoutFill() {
        let view = makeButton(text: "Fill", style: .primary.layoutBehavior(.fill))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_primary_layoutHug() {
        let view = makeButton(text: "Hug", style: .primary.layoutBehavior(.hug))
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_primary_layoutFixed() {
        let view = makeButton(text: "Fixed 200", style: .primary.layoutBehavior(.fixed(200)))
        assertButtonSnapshot(of: view)
    }
    
    // MARK: - Multi-line Text Tests
    
    func test_SEBGreenButtonStyle_primary_multilineText() {
        let view = makeButton(
            text: "This is a very long button label that will wrap to multiple lines",
            style: .primary
        )
        assertButtonSnapshot(of: view)
    }
    
    func test_SEBGreenButtonStyle_secondary_multilineTextWithIcon() {
        let view = makeButton(
            text: "This is a very long button label with an icon that will wrap",
            systemImage: "star.fill",
            style: .secondary
        )
        assertButtonSnapshot(of: view)
    }
}
