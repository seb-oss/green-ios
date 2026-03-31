//
// Copyright © 2026 Skandinaviska Enskilda Banken AB (publ). All rights reserved.
//

import SwiftUI

public struct CommunicationBanner: View {
    private let model: Model
    private let actions: Actions

    public init(
        model: Model,
        actions: Actions = .init()
    ) {
        self.model = model
        self.actions = actions
    }

    public var body: some View {
        GroupBox(model.title) {
            VStack(alignment: .leading, spacing: .space2xs) {
                Text(model.message)

                if let callToAction = actions.callToAction {
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
            .communicationBanner(
                variant: model.variant,
                onClose: actions.onClose
            )
        )
    }
}

extension CommunicationBanner {
    public enum Variant: CaseIterable, Equatable {
        case information
        case notice
        case warning
        case error
    }

    public struct Model: Equatable {
        public let title: String
        public let message: String
        public let variant: Variant

        public init(
            title: String,
            message: String,
            variant: Variant
        ) {
            self.title = title
            self.message = message
            self.variant = variant
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
            CommunicationBanner(
                model: .init(
                    title: "Information",
                    message:
                        "Used for passive, non-critical updates like tips or background information.",
                    variant: .information
                ),
                actions: .init(onClose: {})
            )
            CommunicationBanner(
                model: .init(
                    title: "Notice",
                    message:
                        "Used for actionable, attention-worthy updates that are still non-critical.",
                    variant: .notice
                ),
                actions: .init(
                    onClose: {},
                    callToAction: .init(
                        title: "See details",
                        linkStyle: .internalLink,
                        action: {}
                    )
                )
            )

            CommunicationBanner(
                model: .init(
                    title: "Warning",
                    message:
                        "Used to highlight important risks or information related to surrounding context.",
                    variant: .warning
                ),
                actions: .init(
                    callToAction: .init(
                        title: "Read more",
                        linkStyle: .externalLink,
                        action: {}
                    )
                )
            )

            CommunicationBanner(
                model: .init(
                    title: "Error",
                    message:
                        "Used to communicate that something has gone wrong or does not work and needs user attention.",
                    variant: .error
                ),
                actions: .init(onClose: {})
            )
        }
        .padding(.spaceM)
    }
    .surface(.neutral02)
}
