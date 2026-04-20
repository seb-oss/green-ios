import SwiftUI

public struct CalloutGroupBoxStyle: GroupBoxStyle {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.surface) private var surface

    let backgroundColor: AnyShapeStyle
    let ignoreBackgroundOpacity: Bool
    let borderColor: Color
    let shouldShowBorder: @Sendable (Surface) -> Bool
    let iconColor: Color
    let textColor: Color
    let iconSystemName: String?

    private var shouldReduceBackgroundOpacity: Bool {
        !ignoreBackgroundOpacity && colorScheme == .dark
    }

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .spaceXs) {
            header(configuration.label)
                .padding(.trailing, .spaceM)

            configuration.content
                .typography(.bodyRegularS)
                .foregroundStyle(textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.spaceM)
        .background(
            backgroundColor.opacity(
                shouldReduceBackgroundOpacity ? 0.8 : 1
            ),
            in: .rect(cornerRadius: .cornerRadius)
        )
        .overlay {
            if shouldShowBorder(surface) {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .strokeBorder(borderColor, style: .init())
            }
        }
    }

    private func header<Content: View>(_ label: Content) -> some View {
        AdaptiveStack(
            spacing: .space2xs,
            horizontalAlignment: .leading
        ) {
            if let iconSystemName {
                Icon(systemName: iconSystemName)
                    .foregroundStyle(iconColor)
                    .accessibilityHidden(true)
            }

            label
                .typography(.headingXs)
                .foregroundStyle(textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Helpers that will be removed as soon as GDKs tokens are updated

extension CGFloat {
    static let cornerRadius = 16.0
    static let cornerRadiusLightWidth = 1.5
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
