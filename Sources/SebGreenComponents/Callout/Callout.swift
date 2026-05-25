import SwiftUI

public struct Callout: View {
    @Environment(\.surface) private var surface
    @Environment(\.calloutStyle) private var calloutStyle

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
    
    private var primaryActionStyle: GreenButtonStyle {
        if case .information(.subtle) = calloutStyle {
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
        GroupBox(title) {
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
        }
        .overlay(alignment: .topTrailing) {
            if let onClose {
                closeButton(onClose: onClose)
            }
        }
        .groupBoxStyle(.callout(calloutStyle))
    }

    @ViewBuilder
    private func closeButton(onClose: @escaping () -> Void) -> some View {
        let colors = calloutStyle.closeButtonColors(
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
        .accessibilityLabel("GreeniOS.Accessibility.Dismiss")
        .padding([.top, .trailing], .gds(.spaceXs))
    }
}

@available(iOS 17, *)
#Preview("Callout") {
    CalloutDemo()
}
