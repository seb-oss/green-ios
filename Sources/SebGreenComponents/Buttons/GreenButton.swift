import SwiftUI

// MARK: - Public API

/// Green Design System — Button component
///
/// Supports:
/// - Kinds: brand, primary, secondary, tertiary, outline, negative
/// - Sizes: xLarge, large, medium, small
/// - Content: text-only, text + leading icon, text + trailing icon, icon-only
/// - States: normal, pressed (via `configuration.isPressed`), disabled
/// - Dynamic Type scaling for fonts, paddings, corner radius and icon sizes
/// - Multiline label with left-aligned text while the whole stack remains centered
/// - Capsule-like single line; retains single-line corner radius on multiline
public struct GreenButton: View {
    private let title: String?
    private let kind: Kind
    private let size: Size
    private let icon: Image?
    private let iconPosition: IconPosition
    private let isEnabled: Bool
    private let action: () -> Void
    
    public init(
        title: String? = nil,
        kind: Kind = .primary,
        size: Size = .large,
        icon: Image? = nil,
        iconPosition: IconPosition = .leading,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.kind = kind
        self.size = size
        self.icon = icon
        self.iconPosition = iconPosition
        self.isEnabled = isEnabled
        self.action = action
    }
    
    public init(config: GreenButtonSchema, action: @escaping () -> Void) {
        self.init(
            title: config.title,
            kind: config.kind,
            size: config.size,
            icon: config.iconSystemName.map { Image(systemName: $0) },
            iconPosition: config.iconPosition ?? .leading,
            isEnabled: config.enabled ?? true,
            action: action
        )
    }
    
    public var body: some View {
        Button(action: action) {
            GreenButtonLabel(title: title, icon: icon, iconPosition: iconPosition, size: size)
        }
        .buttonStyle(GreenButtonStyle(kind: kind, size: size))
        .disabled(!isEnabled)
        // Allow parent to choose width; by default the button hugs its content
    }
}

// MARK: - Previews

struct GreenButton_Previews: PreviewProvider {
    static let arrangement: Arrangement = .vertically
    
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach([GreenButton.Kind.brand, .primary, .secondary, .tertiary, .outline, .negative], id: \.self) { kind in
                    VStack(alignment: .center, spacing: 12) {
                        Text("\(kind.rawValue.capitalized) — Sizes")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        // Row: text only
                        Text("Text only")
                        [
                            GreenButton(title: "Label", kind: kind, size: .xLarge, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .large, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .medium, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .small, action: {})
                        ].stack(arrangement: arrangement)
                        
                        // Row: text + leading icon
                        Text("Text + leading icon")
                        [
                            GreenButton(title: "Label", kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .large, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .small, icon: Image(systemName: "arrow.right"), iconPosition: .leading, action: {})
                        ].stack(arrangement: arrangement)
                        
                        // Row: text + trailing icon
                        Text("Text + trailing icon")
                        [
                            GreenButton(title: "Label", kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .large, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {}),
                            GreenButton(title: "Label", kind: kind, size: .small, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {})
                        ].stack(arrangement: arrangement)
                        
                        // Row: icon only
                        Text("Icon only")
                        [
                            GreenButton(title: nil, kind: kind, size: .xLarge, icon: Image(systemName: "arrow.right"), action: {})
                                .accessibilityLabel("Next"),
                            GreenButton(title: nil, kind: kind, size: .large, icon: Image(systemName: "arrow.right"), action: {})
                                .accessibilityLabel("Next"),
                            GreenButton(title: nil, kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), action: {})
                                .accessibilityLabel("Next"),
                            GreenButton(title: nil, kind: kind, size: .small, icon: Image(systemName: "arrow.right"), action: {})
                                .accessibilityLabel("Next")
                        ].stack(arrangement: arrangement)
                        
                        // Disabled row
                        Text("Disabled")
                        [
                            GreenButton(title: "Label", kind: kind, size: .medium, action: {})
                                .disabled(true),
                            GreenButton(title: "Label", kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {})
                                .disabled(true),
                            GreenButton(title: nil, kind: kind, size: .medium, icon: Image(systemName: "arrow.right"), action: {})
                                .disabled(true)
                        ].stack(arrangement: arrangement)
                    }
                }
                
                // Multiline showcase: constrained width
                Text("Multiline wrapping (left aligned text)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 12) {
                    GreenButton(title: "A very \nlong label that will wrap onto the next line when width is narrow", kind: .primary, size: .large, icon: Image(systemName: "arrow.right"), iconPosition: .trailing, action: {})
                        .frame(width: 220)
                    GreenButton(title: "Icon-only long demo is irrelevant", kind: .outline, size: .large, icon: Image(systemName: "star.fill"), action: {})
                        .frame(width: 140)
                }
            }
            .padding(20)
        }
        .previewLayout(.sizeThatFits)
    }
}

enum Arrangement {
    case horizontally
    case vertically
}

extension Array where Element: View {
    @ViewBuilder
    func stack(
        _ alignment: Alignment = .center,
        spacing: CGFloat = .spaceXs,
        arrangement: Arrangement = .horizontally
    ) -> some View {
        switch arrangement {
        case .horizontally:
            HStack(alignment: alignment.vertical, spacing: spacing) {
                ForEach(indices, id: \.self) { i in
                    self[i]
                }
            }
        case .vertically:
            VStack(alignment: alignment.horizontal, spacing: spacing) {
                ForEach(indices, id: \.self) { i in
                    self[i]
                }
            }
        }
    }
}
