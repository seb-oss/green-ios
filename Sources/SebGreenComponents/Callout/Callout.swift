import SwiftUI

public struct Callout: View {
    @Environment(\.surface) private var surface
    @Environment(\.calloutStyle) private var variant

    private let title: any StringProtocol
    private let shortText: any StringProtocol
    private let action: Callout.Action?
    private let onClose: (() -> Void)?

    public init(
        _ title: any StringProtocol,
        shortText: any StringProtocol,
        action: Callout.Action? = nil,
        onClose: (() -> Void)? = nil
    ) {
        self.title = title
        self.shortText = shortText
        self.action = action
        self.onClose = onClose
    }
    
    private var style: CalloutStyle { .callout(variant) }

    private var primaryActionStyle: GreenButtonStyle {
        if case .information(.subtle) = variant {
            .secondary(
                dimensions: .small,
                iconPosition: .trailing
            )
        } else {
            .tonal(
                dimensions: .small,
                iconPosition: .trailing
            )
        }
    }

    public var body: some View {
        let callout = VStack(alignment: .leading, spacing: .gds(.spaceXs)) {
            header
            content
        }
        .padding(.gds(.spaceM))
        .background(style.backgroundColor, in: .rect(cornerRadius: .gds(.radiusM)))
        .overlay {
            RoundedRectangle(cornerRadius: .gds(.radiusM))
                .strokeBorder(style.borderColor, style: .init())
        }
        .overlay(alignment: .topTrailing) {
            if let onClose {
                closeButton(onClose: onClose)
                    .accessibilityHidden(true)
            }
        }
        .accessibilityElement(children: .combine)
        
        if let onClose {
            callout
                .accessibilityAction(
                    named: Text(
                        "GreeniOS.Accessibility.Dismiss",
                        bundle: .module,
                    ),
                    onClose
                )
        } else {
            callout
        }
    }

    private var header: some View {
        AdaptiveStack(spacing: .gds(.space2xs), horizontalAlignment: .leading) {
            if let icon = style.severityIcon {
                Icon(systemName: icon.iconSystemName)
                    .foregroundStyle(style.iconColor)
                    .accessibilityLabel(icon.accessibilitySeverityLabel)
            }

            Text(title)
                .font(.gds(.headingXs))
                .foregroundStyle(style.textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.trailing, .gds(.spaceM))
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: .gds(.spaceS)) {
            Text(shortText)

            if let action {
                Button(
                    action.title,
                    systemImage: action.linkStyle?.symbolName ?? "",
                    action: action.perform
                )
                .buttonStyle(.gds(primaryActionStyle))
                .level(.level2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.gds(.bodySRegular))
        .foregroundStyle(style.textColor)
        .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private func closeButton(onClose: @escaping () -> Void) -> some View {
        let colors = variant.closeButtonColors(
            surface: surface
        )

        Button(
            systemName: "xmark.circle.fill",
            dynamicTypeSizeRange: DynamicTypeSize.xxxLarge ..< .accessibility1,
            action: onClose
        )
        .foregroundStyle(
            colors.primary,
            colors.secondary
        )
        .contentShape(.circle)
        .padding([.top, .trailing], .gds(.spaceXs))
    }
}

@available(iOS 17, *)
#Preview("Callout") {
    CalloutDemo()
}
