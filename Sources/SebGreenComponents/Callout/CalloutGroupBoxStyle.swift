import SwiftUI

struct CalloutGroupBoxStyle: GroupBoxStyle {
    let backgroundColor: Color
    let borderColor: Color
    let iconColor: Color
    let textColor: Color
    let closeButtonPrimaryColor: Color
    let closeButtonSecondaryColor: Color
    let iconSystemName: String?

    func makeBody(configuration: Configuration) -> some View {
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
            backgroundColor,
            in: .rect(cornerRadius: .cornerRadius)
        )
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
