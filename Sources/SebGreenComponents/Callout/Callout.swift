//
// Copyright © 2026 Skandinaviska Enskilda Banken AB (publ). All rights reserved.
//

import SwiftUI

public struct Callout: View {
    private let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        GroupBox(model.title) {
            VStack(alignment: .leading, spacing: .space2xs) {
                Text(model.shortText)

                if let callToAction = model.actions.callToAction {
                    GreenButton(
                        title: callToAction.title,
                        kind: .tertiary,
                        size: .small,
                        icon: callToAction.linkStyle.map {
                            Image(systemName: $0.symbolName)
                        },
                        iconPosition: .trailing,
                        action: callToAction.action
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .groupBoxStyle(
            .callout(
                variant: model.variant,
                onClose: model.actions.onClose
            )
        )
    }
}

extension Callout {
    public enum Variant: CaseIterable, Equatable {
        case information
        case notice
        case warning
        case error
    }

    public struct Model: Identifiable {
        public let id: String
        public let title: String
        public let shortText: String
        public let message: String?
        public let variant: Variant
        public let actions: Actions

        public init(
            id: String,
            title: String,
            shortText: String,
            message: String? = nil,
            variant: Variant,
            actions: Actions = .init()
        ) {
            self.id = id
            self.title = title
            self.shortText = shortText
            self.message = message
            self.variant = variant
            self.actions = actions
        }
    }

    public struct Actions {
        public struct CallToAction {
            public enum LinkStyle: Equatable {
                case internalLink
                case externalLink

                fileprivate var symbolName: String {
                    switch self {
                    case .internalLink:
                        return "arrow.right"
                    case .externalLink:
                        return "arrow.up.right"
                    }
                }
            }

            public let title: String
            public let linkStyle: LinkStyle?
            public let action: () -> Void

            public init(
                title: String,
                linkStyle: LinkStyle? = nil,
                action: @escaping () -> Void
            ) {
                self.title = title
                self.linkStyle = linkStyle
                self.action = action
            }
        }

        public let onClose: (() -> Void)?
        public let callToAction: CallToAction?

        public init(
            onClose: (() -> Void)? = nil,
            callToAction: CallToAction? = nil
        ) {
            self.onClose = onClose
            self.callToAction = callToAction
        }
    }
}

#Preview("Alert") {
    ScrollView {
        VStack(alignment: .leading, spacing: .spaceM) {
            Callout(
                model: .init(
                    id: "1",
                    title: "Information",
                    shortText:
                        "Used for passive, non-critical updates like tips or background information.",
                    variant: .information,
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
                    title: "Error",
                    shortText:
                        "Used to communicate that something has gone wrong or does not work and needs user attention.",
                    variant: .error,
                    actions: .init(onClose: {})
                ),
            )
        }
        .padding(.spaceM)
    }
    .surface(.neutral02)
}
