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
/// Why `GreenList` instead of native `List`:
/// - Predictable visuals across iOS versions and host apps (no reliance on `List` / `UITableView` defaults).
/// - Full control over backgrounds, insets, separators, corner radii, and elevation for the four GDS list styles.
/// - Composable in any container (cards, sheets, nested scroll views) without inheriting unwanted `List` behavior.
///
/// Responsibilities:
/// - Owns background style (plain / grouped / elevated / elevatedGrouped).
/// - Provides the correct spacing, insets, and clipping per style.
/// - Hosts `GreenRow` instances or any custom content while preserving the above guarantees.
public struct GreenList<Content: View>: View {

    public enum Style {
        /// Full-bleed list on base background.
        case plain
        /// List presented as a grouped/card surface on a contrasting background.
        case grouped
        /// Full-width elevated surface (e.g. sheet or panel) on a contrasting background.
        case elevated
        /// Grouped elevated surface (cards on elevated background).
        case elevatedGrouped
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
            }
            .background(listBackground)
            .clipShape(listClipShape)
            .padding(listOuterPadding)
        }
        .background(listContainerBackground.ignoresSafeArea())
    }

    private var listBackground: Color {
        switch style {
        case .plain, .grouped:
            return .l1Neutral01
        case .elevated, .elevatedGrouped:
            return .l1Elevated01
        }
    }

    private var listContainerBackground: Color {
        switch style {
        case .plain, .grouped:
            return .l1Neutral02
        case .elevated, .elevatedGrouped:
            return .l1Neutral02
        }
    }

    private var listClipShape: some Shape {
        switch style {
        case .plain:
            // Full-bleed, no rounding
            return AnyShape(Rectangle())
        case .grouped:
            // Single grouped surface
            return AnyShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        case .elevated:
            // Elevated full-width surface
            return AnyShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        case .elevatedGrouped:
            // Elevated grouped/card surface
            return AnyShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }

    private var listOuterPadding: EdgeInsets {
        switch style {
        case .plain:
            // Full-width list anchored to safe area
            return EdgeInsets(top: .spaceL, leading: .space0, bottom: .spaceL, trailing: .space0)
        case .grouped:
            // Grouped card inset horizontally and vertically
            return EdgeInsets(top: .spaceL, leading: .spaceM, bottom: .spaceL, trailing: .spaceM)
        case .elevated:
            // Elevated sheet-like surface inset horizontally
            return EdgeInsets(top: .spaceL, leading: .spaceM, bottom: .spaceL, trailing: .spaceM)
        case .elevatedGrouped:
            // Elevated grouped lists in cards
            return EdgeInsets(top: .spaceL, leading: .spaceM, bottom: .spaceL, trailing: .spaceM)
        }
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

    struct AllRowVariations: View {
        @State private var toggleNotifications = true
        @State private var toggleWifiOnly = false

        var body: some View {
            Group {
                // MARK: List 72 (tall rows)

                Text("List 72")
                    .typography(.detailRegularS)
                    .foregroundColor(.contentNeutral03)
                    .padding(.horizontal, .spaceM)
                    .padding(.top, .spaceS)

                // 72: No leading / no trailing
                GreenRow(
                    title: "Headline",
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading icon
                GreenRow(
                    title: "Headline",
                    subtitle: "Sub headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    size: .list72,
                    onTap: {}
                )

                // 72: Trailing chevron only
                GreenRow(
                    title: "Headline",
                    leading: .none,
                    trailing: .chevron,
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading icon + trailing chevron
                GreenRow(
                    title: "Headline",
                    subtitle: "Sub headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .chevron,
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading icon + trailing value text
                GreenRow(
                    title: "Headline",
                    subtitle: "Sub headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .valueText("Value"),
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading icon + trailing icon
                GreenRow(
                    title: "Headline",
                    subtitle: "Sub headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .icon(Image(systemName: "info.circle")),
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading checkbox unchecked
                GreenRow(
                    title: "Checkbox option",
                    leading: .checkbox(isSelected: false),
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading checkbox selected
                GreenRow(
                    title: "Checkbox selected",
                    leading: .checkbox(isSelected: true),
                    size: .list72,
                    isSelected: true,
                    onTap: {}
                )

                // 72: Leading radio unselected
                GreenRow(
                    title: "Radio option",
                    leading: .radio(isSelected: false),
                    size: .list72,
                    onTap: {}
                )

                // 72: Leading radio selected
                GreenRow(
                    title: "Radio selected",
                    leading: .radio(isSelected: true),
                    size: .list72,
                    isSelected: true,
                    onTap: {}
                )

                // 72: Disabled row
                GreenRow(
                    title: "Disabled row",
                    subtitle: "Not available right now",
                    leading: .icon(Image(systemName: "lock.fill")),
                    size: .list72,
                    isEnabled: false,
                    onTap: {}
                )

                // MARK: List 56 (compact rows)

                Text("List 56")
                    .typography(.detailRegularS)
                    .foregroundColor(.contentNeutral03)
                    .padding(.horizontal, .spaceM)
                    .padding(.top, .spaceL)

                // 56: No leading / chevron
                GreenRow(
                    title: "Headline",
                    trailing: .chevron,
                    size: .list56,
                    onTap: {}
                )

                // 56: Leading icon
                GreenRow(
                    title: "Headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    size: .list56,
                    onTap: {}
                )

                // 56: Leading icon + trailing value
                GreenRow(
                    title: "Headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .valueText("Value"),
                    size: .list56,
                    onTap: {}
                )

                // 56: Leading icon + trailing icon
                GreenRow(
                    title: "Headline",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .icon(Image(systemName: "info.circle")),
                    size: .list56,
                    onTap: {}
                )

                // 56: Leading icon + trailing toggle
                GreenRow(
                    title: "Notifications",
                    subtitle: "Push and email alerts",
                    leading: .icon(Image(systemName: "bell.fill")),
                    trailing: .toggle(isOn: $toggleNotifications),
                    size: .list56
                )

                // 56: Trailing toggle only
                GreenRow(
                    title: "Wi‑Fi only",
                    trailing: .toggle(isOn: $toggleWifiOnly),
                    size: .list56
                )

                // 56: Trailing checkbox
                GreenRow(
                    title: "Checkbox trailing",
                    trailing: .checkbox(isSelected: true),
                    size: .list56,
                    isSelected: true
                )

                // 56: Trailing radio
                GreenRow(
                    title: "Radio trailing",
                    trailing: .radio(isSelected: true),
                    size: .list56,
                    isSelected: true
                )

                // 56: Disabled compact row
                GreenRow(
                    title: "Disabled compact row",
                    leading: .icon(Image(systemName: "lock.fill")),
                    size: .list56,
                    isEnabled: false
                )
            }
        }
    }

    struct PlainBackgroundPreview: View {
        var body: some View {
            GreenList(style: .plain) {
                AllRowVariations()
            }
        }
    }

    struct GroupedBackgroundPreview: View {
        var body: some View {
            GreenList(style: .grouped) {
                AllRowVariations()
            }
        }
    }

    struct ElevatedBackgroundPreview: View {
        var body: some View {
            ZStack(alignment: .top) {
                Color.black
                    .frame(height: 56)
                    .ignoresSafeArea(edges: .top)

                GreenList(style: .elevated) {
                    AllRowVariations()
                }
            }
        }
    }

    struct ElevatedGroupedBackgroundPreview: View {
        var body: some View {
            ZStack(alignment: .top) {
                Color.black
                    .frame(height: 56)
                    .ignoresSafeArea(edges: .top)

                GreenList(style: .elevatedGrouped) {
                    AllRowVariations()
                }
            }
        }
    }

    static var previews: some View {
        Group {
            PlainBackgroundPreview()
                .previewDisplayName("Background • plain")

            GroupedBackgroundPreview()
                .previewDisplayName("Grouped Background")

            ElevatedBackgroundPreview()
                .previewDisplayName("Elevated Background")

            ElevatedGroupedBackgroundPreview()
                .previewDisplayName("Elevated Grouped Background")
        }
    }
}

