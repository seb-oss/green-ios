//
//  GreenList.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-11-09.
//

import SwiftUI
import GdsKit

// MARK: - GreenList

/// A design-system friendly list container used by SDUI and native code.
///
/// Responsibilities:
/// - Owns background style (plain / grouped / card).
/// - Provides correct vertical spacing and horizontal insets.
/// - Hosts `GreenRow` instances or any custom content.
public struct GreenList<Content: View>: View {

    public enum Style {
        case plain          // full-bleed background
        case grouped        // grouped background, full-bleed
        case card           // card-style surface within parent background
    }

    private let style: Style
    private let showsSeparators: Bool
    private let content: () -> Content

    public init(
        style: Style = .plain,
        showsSeparators: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = style
        self.showsSeparators = showsSeparators
        self.content = content
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0, pinnedViews: []) {
                content()
                    .modifier(SeparatorListModifier(isVisible: showsSeparators))
            }
            .background(listBackground)
            .clipShape(listClipShape)
            .padding(listOuterPadding)
        }
        .background(listContainerBackground.ignoresSafeArea())
    }

    private var listBackground: Color {
        switch style {
        case .plain:
            return .clear
        case .grouped, .card:
            return .l1Neutral01
        }
    }

    private var listContainerBackground: Color {
        switch style {
        case .plain:
            return .l1Neutral01
        case .grouped:
            return .l1Neutral02
        case .card:
            return .l1Neutral02
        }
    }

    private var listClipShape: some Shape {
        switch style {
        case .plain:
            return AnyShape(Rectangle())
        case .grouped:
            return AnyShape(Rectangle())
        case .card:
            return AnyShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }

    private var listOuterPadding: EdgeInsets {
        switch style {
        case .plain:
            return EdgeInsets(top: .space0, leading: .space0, bottom: .space0, trailing: .space0)
        case .grouped:
            return EdgeInsets(top: .spaceM, leading: .space0, bottom: .spaceM, trailing: .space0)
        case .card:
            return EdgeInsets(top: .spaceM, leading: .spaceM, bottom: .spaceM, trailing: .spaceM)
        }
    }
}

// MARK: - Separator Modifier

private struct SeparatorListModifier: ViewModifier {
    let isVisible: Bool

    func body(content: Content) -> some View {
        if isVisible {
            content
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.borderSeparator01)
                        .frame(height: 0.5)
                }
        } else {
            content
        }
    }
}

// MARK: - AnyShape helper

private struct AnyShape: Shape {
    private let pathBuilder: @Sendable (CGRect) -> Path

    init<S: Shape>(_ wrapped: S) {
        self.pathBuilder = { rect in
            wrapped.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        pathBuilder(rect)
    }
}

// MARK: - GreenRow

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
        .accessibilityElement(children: .combine)
        .accessibility(addTraits: accessibilityTraits)
    }

    private var rowContent: some View {
        HStack(alignment: .center, spacing: .spaceM) {
            leadingView

            VStack(alignment: .leading, spacing: subtitle == nil ? 0 : 2) {
                Text(title)
                    .font(.body)
                    .foregroundColor(titleColor)
                    .lineLimit(nil)

                if let subtitleText = subtitle {
                    Text(subtitleText)
                        .font(.subheadline)
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
                .foregroundColor(isSelected ? .statePositive01 : .contentNeutral02)
        case .radio(let isSelected):
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .stateBrand01 : .contentNeutral02)
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
                .foregroundColor(.contentNeutral03)
        case .valueText(let text):
            Text(text)
                .font(.subheadline)
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
                .foregroundColor(isSelected ? .statePositive01 : .contentNeutral02)
        case .radio(let isSelected):
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .imageScale(.medium)
                .foregroundColor(isSelected ? .stateBrand01 : .contentNeutral02)
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

// MARK: - Previews

struct GreenList_Previews: PreviewProvider {

    struct PreviewToggleModel: View {
        @State private var wifiOn: Bool = true
        @State private var notificationsOn: Bool = false

        var body: some View {
            GreenList(style: .grouped) {
                Group {
                    GreenRow(
                        title: "Profile",
                        subtitle: "Personal details and security",
                        leading: .icon(Image(systemName: "person.circle.fill")),
                        trailing: .chevron,
                        size: .list72,
                        onTap: {}
                    )

                    GreenRow(
                        title: "Savings account",
                        subtitle: "••• 1234",
                        leading: .icon(Image(systemName: "creditcard")),
                        trailing: .valueText("120 000 kr"),
                        size: .list56,
                        onTap: {}
                    )

                    GreenRow(
                        title: "Notifications",
                        subtitle: "Push and email alerts",
                        leading: .icon(Image(systemName: "bell.fill")),
                        trailing: .toggle(isOn: $notificationsOn),
                        size: .list56
                    )

                    GreenRow(
                        title: "Wi‑Fi only",
                        leading: .checkbox(isSelected: wifiOn),
                        trailing: .none,
                        size: .list56,
                        isSelected: wifiOn,
                        onTap: { wifiOn.toggle() }
                    )

                    GreenRow(
                        title: "Radio option selected",
                        leading: .radio(isSelected: true),
                        trailing: .none,
                        size: .list56,
                        isSelected: true,
                        onTap: {}
                    )

                    GreenRow(
                        title: "Disabled row",
                        subtitle: "Not available right now",
                        leading: .icon(Image(systemName: "lock.fill")),
                        trailing: .chevron,
                        size: .list56,
                        isEnabled: false,
                        onTap: {}
                    )
                }
            }
        }
    }

    static var previews: some View {
        Group {
            PreviewToggleModel()
                .previewDisplayName("GreenList • grouped • mixed rows")

            GreenList(style: .card) {
                GreenRow(
                    title: "Card-style list",
                    subtitle: "Use for sheets or grouped surfaces",
                    leading: .icon(Image(systemName: "doc.text")),
                    trailing: .chevron,
                    size: .list72,
                    onTap: {}
                )
                GreenRow(
                    title: "Multiline title that wraps onto multiple lines when space is constrained for demonstration purposes",
                    subtitle: "And a longer subtitle to confirm multiline behavior.",
                    leading: .none,
                    trailing: .valueText("Value"),
                    size: .list72,
                    onTap: {}
                )
            }
            .previewDisplayName("GreenList • card • multiline")
        }
    }
}

