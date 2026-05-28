import SwiftUI
import GdsDimensions

public struct CalloutGroupBoxStyle: GroupBoxStyle {
    let backgroundColor: AnyShapeStyle
    let borderColor: Color
    let iconColor: Color
    let textColor: Color
    let iconSystemName: String?

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .gds(.spaceXs)) {
            header(configuration.label)
                .padding(.trailing, .gds(.spaceM))

            configuration.content
                .font(.gds(.bodySRegular))
                .foregroundStyle(textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.gds(.spaceM))
        .background(
            backgroundColor,
            in: .rect(cornerRadius: .gds(.radiusM))
        )
        .overlay {
            RoundedRectangle(cornerRadius: .gds(.radiusM))
                .strokeBorder(borderColor, style: .init())
        }
    }

    private func header<Content: View>(_ label: Content) -> some View {
        AdaptiveStack(
            spacing: .gds(.space2xs),
            horizontalAlignment: .leading
        ) {
            if let iconSystemName {
                Icon(systemName: iconSystemName)
                    .foregroundStyle(iconColor)
                    .accessibilityHidden(true)
            }

            label
                .font(.gds(.headingXs))
                .foregroundStyle(textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
