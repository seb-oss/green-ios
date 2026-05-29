import SwiftUI

public struct Callout: View {
    @Environment(\.surface) private var surface
    @Environment(\.calloutAppearance) private var appearance

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

    public var body: some View {
        let callout = VStack(alignment: .leading, spacing: .gds(.spaceXs)) {
            header
            content
        }
        .padding(.gds(.spaceM))
        .background(appearance.backgroundColor, in: .rect(cornerRadius: .gds(.radiusM)))
        .overlay {
            RoundedRectangle(cornerRadius: .gds(.radiusM))
                .strokeBorder(appearance.borderColor)
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
            if let icon = appearance.severityIcon {
                Icon(systemName: icon.iconSystemName)
                    .foregroundStyle(appearance.iconColor)
                    .accessibilityLabel(icon.accessibilitySeverityLabel)
            }

            Text(title)
                .font(.gds(.headingXs))
                .foregroundStyle(appearance.textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.trailing, .gds(.spaceM))
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: .gds(.spaceS)) {
            Text(shortText)
                .multilineTextAlignment(.leading)

            if let action {
                Button(
                    action.title,
                    systemImage: action.linkStyle?.symbolName ?? "",
                    action: action.perform
                )
                .buttonStyle(.gds(appearance.primaryActionStyle))
                .level(.level2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.gds(.bodySRegular))
        .foregroundStyle(appearance.textColor)
        .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private func closeButton(onClose: @escaping () -> Void) -> some View {
        let colors = appearance.closeButtonColors(surface)

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
