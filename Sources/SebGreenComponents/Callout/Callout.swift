import SwiftUI

public struct Callout: View {
    @Environment(\.surface) private var surface
    @Environment(\.calloutStyle) private var calloutStyle

    private let title: any StringProtocol
    private let shortText: any StringProtocol
    private let message: (any StringProtocol)?
    private let action: Callout.Action?
    private let onClose: (() -> Void)?

    public init(
        _ title: any StringProtocol,
        shortText: any StringProtocol,
        message: (any StringProtocol)? = nil,
        action: Callout.Action? = nil,
        onClose: (() -> Void)? = nil
    ) {
        self.title = title
        self.shortText = shortText
        self.message = message
        self.action = action
        self.onClose = onClose
    }

    public var body: some View {
        GroupBox(title) {
            VStack(alignment: .leading, spacing: .spaceS) {
                Text(shortText)

                if let action {
                    // TODO: Use Button with GDS-style instead
                    Button(
                        action.title,
                        systemImage: action.linkStyle?.symbolName ?? "",
                        action: action.perform
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, .spaceXs)
                    .background(Color.white.opacity(0.12))
                    .clipShape(.capsule)
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
        .accessibilityLabel("Dismiss")
        .padding([.top, .trailing], .spaceXs)
    }
}

#Preview("Alert") {
    ScrollView {
        VStack(alignment: .leading, spacing: .spaceM) {
            Callout(
                "Information (Subtle)",
                shortText:
                    "Used for passive, non-critical updates like tips or background information.",
                action: .init(
                    title: "See details",
                    linkStyle: .internalLink,
                    action: {}
                )

            ) {}
            .calloutStyle(.information(.subtle))

            Callout(
                "Information (Loud)",
                shortText:
                    "Used for passive, non-critical updates like tips or background information.",
            ) {}
            .calloutStyle(.information(.loud))

            Callout(
                "Notice",
                shortText:
                    "Used for actionable, attention-worthy updates that are still non-critical.",
                action: .init(
                    title: "See details",
                    linkStyle: .internalLink,
                    action: {}
                )
            ) {}
            .calloutStyle(.notice)

            Callout(
                "Warning",
                shortText:
                    "Used to highlight important risks or information related to surrounding context.",
                action: .init(
                    title: "Read more",
                    linkStyle: .externalLink,
                    action: {}
                )
            ) {}
            .calloutStyle(.warning)

            Callout(
                "Critical",
                shortText:
                    "Used to communicate that something has gone wrong or does not work and needs user attention.",
            ) {}
            .calloutStyle(.critical)
        }
        .padding(.spaceM)
    }
    .surface(.neutral02)
}
