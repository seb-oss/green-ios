//
//  GreenRow.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-11-18.
//

import SwiftUI

/// Core list row for the Green design system.
/// All visual/state variations in the spec should be expressible via this API.
public struct GreenRow: View, Identifiable {

    // Exposed for SDUI and native composition.
    public enum Size {
        case list56
        case list72
    }

    public enum LeadingContent {
        case none
        case icon(Image)
        case checkbox(isSelected: Bool)
        case radio(isSelected: Bool)
    }

    public enum TrailingContent {
        case none
        case chevron
        case valueText(String)
        case icon(Image)
        case toggle(isOn: Binding<Bool>)
        case checkbox(isSelected: Bool)
        case radio(isSelected: Bool)
    }

    public let id: String
    public let title: String
    public let subtitle: String?
    public let leading: LeadingContent
    public let trailing: TrailingContent
    public let size: Size
    public let isEnabled: Bool
    public let isSelected: Bool
    public let onTap: (() -> Void)?

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String? = nil,
        leading: LeadingContent = .none,
        trailing: TrailingContent = .none,
        size: Size = .list56,
        isEnabled: Bool = true,
        isSelected: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.leading = leading
        self.trailing = trailing
        self.size = size
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.onTap = onTap
    }

    // MARK: Body

    public var body: some View {
        Group {
            if usesRowButton {
                Button(action: { onTap?() }) {
                    rowContent
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
            } else {
                rowContent
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onTap?()
                    }
                    .disabled(!isEnabled)
            }
        }
        .background(rowBackground)
        .modifier(RowSeparatorModifier(isVisible: true))
        .accessibilityElement(children: .combine)
        .accessibility(addTraits: accessibilityTraits)
    }

    private var rowContent: some View {
        HStack(alignment: .center, spacing: .spaceM) {
            leadingView

            VStack(alignment: .leading, spacing: subtitle == nil ? 0 : 2) {
                Text(title)
                    .typography(.bodyMediumM)
                    .foregroundColor(titleColor)
                    .lineLimit(nil)

                if let subtitleText = subtitle {
                    Text(subtitleText)
                        .typography(.detailRegularS)
                        .foregroundColor(subtitleColor)
                        .lineLimit(nil)
                }
            }

            Spacer(minLength: .spaceS)

            trailingView
        }
        .padding(.horizontal, .spaceM)
        .padding(.vertical, verticalPadding)
        .frame(minHeight: minHeight, alignment: .leading)
    }

    // MARK: Layout helpers

    private var minHeight: CGFloat {
        switch size {
        case .list56: return 56
        case .list72: return 72
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .list56: return max( (56 - 24) / 2, 8) // content + padding
        case .list72: return max( (72 - 24) / 2, 10)
        }
    }

    // MARK: Colors & background

    private var rowBackground: Color {
        if !isEnabled {
            return Color.l1Neutral01
        }
        if isSelected {
            return Color.stateNeutral01.opacity(0.08)
        }
        return Color.l1Neutral01
    }

    private var titleColor: Color {
        isEnabled ? .contentNeutral01 : .contentDisabled01
    }

    private var subtitleColor: Color {
        isEnabled ? .contentNeutral02 : .contentDisabled02
    }

    // MARK: Leading / Trailing views

    @ViewBuilder
    private var leadingView: some View {
        switch leading {
        case .none:
            EmptyView()
        case .icon(let image):
            image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.contentNeutral01)
        case .checkbox(let isSelected):
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .contentPositive01 : .contentNeutral02)
        case .radio(let isSelected):
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .contentNeutral02 : .contentNeutral02)
        }
    }

    @ViewBuilder
    private var trailingView: some View {
        switch trailing {
        case .none:
            EmptyView()
        case .chevron:
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.contentNeutral02)
        case .valueText(let text):
            Text(text)
                .typography(.detailRegularS)
                .foregroundColor(.contentNeutral02)
                .multilineTextAlignment(.trailing)
        case .icon(let image):
            image
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.contentNeutral02)
        case .toggle(let isOnBinding):
            Toggle(isOn: isOnBinding) {
                EmptyView()
            }
            .labelsHidden()
        case .checkbox(let isSelected):
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .contentPositive01 : .contentNeutral02)
        case .radio(let isSelected):
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .contentNeutral02 : .contentNeutral02)
        }
    }

    // MARK: Behavior flags

    /// Rows with inline toggles / switches should not behave as a single big button.
    private var usesRowButton: Bool {
        switch trailing {
        case .toggle:
            return false
        default:
            return onTap != nil
        }
    }

    // MARK: Accessibility

    private var accessibilityTraits: AccessibilityTraits {
        var traits: AccessibilityTraits = []
        if onTap != nil && usesRowButton {
            _ = traits.insert(.isButton)
        }
        if isSelected {
            _ = traits.insert(.isSelected)
        }
        return traits
    }
}

// MARK: - Separator Modifier

/// Draws a separator line at the bottom edge of a single row.
/// Intended to be applied at row-level, not around a whole list.
private struct RowSeparatorModifier: ViewModifier {
    let isVisible: Bool
    let leadingInset: CGFloat = .spaceM

    func body(content: Content) -> some View {
        content.overlay(alignment: .bottom) {
            if isVisible {
                Rectangle()
                    .fill(Color.borderSeparator01)
                    .frame(height: 0.5)
                    .padding(.leading, leadingInset)
            }
        }
    }
}
