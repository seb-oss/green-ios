//
//  GreenButtonPreviewCases.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-01-26.
//

import SwiftUI
import GdsKit

/// Shared preview fixtures for GreenButton used by both previews and snapshot tests.
enum GreenButtonPreviewCases {
    // MARK: - Helpers
    @ViewBuilder
    private static func decorated<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        content()
            .frame(width: 320)
            .padding(.spaceM)
            .background(Color.l2Elevated01)
    }

    // MARK: - Cases

    /// Text-only buttons in all sizes for the given kind, stacked vertically.
    static func textOnly(kind: GreenButton.Kind, arrangement: Arrangement = .vertically) -> some View {
        decorated {
            [
                GreenButton(title: "Label", kind: kind, size: .xLarge, action: {}),
                GreenButton(title: "Label", kind: kind, size: .large, action: {}),
                GreenButton(title: "Label", kind: kind, size: .medium, action: {}),
                GreenButton(title: "Label", kind: kind, size: .small, action: {})
            ].stack(arrangement: arrangement)
        }
    }

    /// Text + leading icon in all sizes for the given kind, stacked vertically.
    static func leadingIcon(kind: GreenButton.Kind, arrangement: Arrangement = .vertically) -> some View {
        decorated {
            [
                GreenButton(title: "Label", kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                GreenButton(title: "Label", kind: kind, size: .large, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                GreenButton(title: "Label", kind: kind, size: .small, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {})
            ].stack(arrangement: arrangement)
        }
    }

    /// Text + trailing icon in all sizes for the given kind, stacked vertically.
    static func trailingIcon(kind: GreenButton.Kind, arrangement: Arrangement = .vertically) -> some View {
        decorated {
            [
                GreenButton(title: "Label", kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                GreenButton(title: "Label", kind: kind, size: .large, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                GreenButton(title: "Label", kind: kind, size: .small, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {})
            ].stack(arrangement: arrangement)
        }
    }

    /// Icon-only buttons in all sizes for the given kind, stacked vertically.
    static func iconOnly(kind: GreenButton.Kind, arrangement: Arrangement = .vertically) -> some View {
        decorated {
            [
                GreenButton(title: nil, kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), action: {}).accessibilityLabel("Next"),
                GreenButton(title: nil, kind: kind, size: .large, icon: Image(systemName: "arrow.right"), action: {}).accessibilityLabel("Next"),
                GreenButton(title: nil, kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), action: {}).accessibilityLabel("Next"),
                GreenButton(title: nil, kind: kind, size: .small, icon: Image(systemName: "arrow.right"), action: {}).accessibilityLabel("Next")
            ].stack(arrangement: arrangement)
        }
    }

    /// Disabled examples for the given kind.
    static func disabled(kind: GreenButton.Kind, arrangement: Arrangement = .vertically) -> some View {
        decorated {
            [
                GreenButton(title: "Label", kind: kind, size: .medium, action: {}).disabled(true),
                GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}).disabled(true),
                GreenButton(title: nil, kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), action: {}).disabled(true)
            ].stack(arrangement: arrangement)
        }
    }
}
