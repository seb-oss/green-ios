import SwiftUI

public struct Callout: View {
    @Environment(\.surface) private var surface

    private let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        GroupBox(model.title) {
            VStack(alignment: .leading, spacing: .spaceS) {
                Text(model.shortText)

                if let callToAction = model.actions.callToAction {
                    // TODO: Use Button with GDS-style instead
                    Button(
                        callToAction.title,
                        systemImage: callToAction.linkStyle?.symbolName ?? "",
                        action: callToAction.action
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
            if let onClose = model.actions.onClose {
                closeButton(onClose: onClose)
            }
        }
        .groupBoxStyle(.callout(model.variant))
    }

    @ViewBuilder
    private func closeButton(onClose: @escaping () -> Void) -> some View {
        let colors = model.variant.closeButtonColors(
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
                model: .init(
                    id: "1",
                    title: "Information (Default)",
                    shortText:
                        "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.default),
                    actions: .init(onClose: {})
                ),
            )

            Callout(
                model: .init(
                    id: "1b",
                    title: "Information (Loud)",
                    shortText:
                        "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.loud),
                    actions: .init(onClose: {})
                ),
            )
            Callout(
                model: .init(
                    id: "2",
                    title: "Notice",
                    shortText:
                        "Used for actionable, attention-worthy updates that are still non-critical.",
                    variant: .notice,
                    actions: .init(
                        onClose: {},
                        callToAction: .init(
                            title: "See details",
                            linkStyle: .internalLink,
                            action: {}
                        )
                    )
                ),
            )

            Callout(
                model: .init(
                    id: "3",
                    title: "Warning",
                    shortText:
                        "Used to highlight important risks or information related to surrounding context.",
                    variant: .warning,
                    actions: .init(
                        callToAction: .init(
                            title: "Read more",
                            linkStyle: .externalLink,
                            action: {}
                        )
                    )
                ),
            )

            Callout(
                model: .init(
                    id: "4",
                    title: "Critical",
                    shortText:
                        "Used to communicate that something has gone wrong or does not work and needs user attention.",
                    variant: .critical,
                    actions: .init(onClose: {})
                ),
            )
        }
        .padding(.spaceM)
    }
    .surface(.neutral02)
}
