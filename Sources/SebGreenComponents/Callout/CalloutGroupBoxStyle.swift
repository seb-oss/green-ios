import SwiftUI

struct CalloutGroupBoxStyle: GroupBoxStyle {
    let variant: Callout.Variant
    let onClose: (() -> Void)?

    private var style: Callout.Variant.Style {
        switch variant {
        case .information: .information
        case .notice: .notice
        case .warning: .warning
        case .critical: .critical
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .spaceXs) {
            header(configuration.label)
                .padding(.trailing, .spaceM)

            configuration.content
                .typography(.bodyRegularS)
                .foregroundStyle(style.textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.spaceM)
        .background(
            style.backgroundColor,
            in: .rect(cornerRadius: .cornerRadius)
        )
        .overlay(alignment: .topTrailing) {
            if let onClose {
                closeButton(onClose: onClose)
            }
        }
    }

    private func header<Content: View>(_ label: Content) -> some View {
        AdaptiveStack(
            spacing: .space2xs,
            horizontalAlignment: .leading
        ) {
            if let name = style.iconSystemName {
                Icon(systemName: name)
                    .foregroundStyle(style.iconColor)
                    .accessibilityHidden(true)
            }

            label
                .typography(.detailBookM)
                .foregroundStyle(style.textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder
    private func closeButton(onClose: @escaping () -> Void) -> some View {
        Button(
            systemName: "xmark.circle.fill",
            dynamicTypeSizeRange: DynamicTypeSize.xxxLarge ..< .accessibility1,
            action: onClose
        )
        .foregroundStyle(
            style.closeButtonPrimaryColor,
            style.closeButtonSecondaryColor
        )
        .contentShape(.circle)
        .accessibilityLabel("Dismiss")
        .padding([.top, .trailing], .spaceXs)
    }
}

extension GroupBoxStyle where Self == CalloutGroupBoxStyle {
    static func callout(
        variant: Callout.Variant,
        onClose: (() -> Void)?
    ) -> CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(variant: variant, onClose: onClose)
    }
}

extension Callout.Variant {
    fileprivate struct Style {
        let backgroundColor: Color
        let borderColor: Color
        let iconColor: Color = .l3Neutral05
        let textColor: Color = .l3Neutral05
        let closeButtonPrimaryColor: Color = .l3Neutral05
        let closeButtonSecondaryColor: Color = .l3Neutral05.opacity(0.12)
        let iconSystemName: String?
    }
}

extension Callout.Variant.Style {
    static var information: Self = .init(
        backgroundColor: .init(hex: 0x3B3F3E),
        borderColor: .clear,
        iconSystemName: nil
    )

    static var notice: Self = .init(
        backgroundColor: .init(hex: 0x2C4454),
        borderColor: .clear,
        iconSystemName: "info.circle"
    )

    static var warning: Self = .init(
        backgroundColor: .init(hex: 0xfA7610C),
        borderColor: .clear,
        iconSystemName: "exclamationmark.triangle"
    )

    static var critical: Self = .init(
        backgroundColor: .init(hex: 0x8A230F),
        borderColor: .clear,
        iconSystemName: "bell"
    )
}

// MARK: - Helpers that will be removed as soon as GDKs tokens are updated

extension CGFloat {
    static let cornerRadius = 16.0
    static let cornerRadiusLightWidth = 1.5
}

extension Color {
    fileprivate init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
