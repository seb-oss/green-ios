extension Callout {
    public enum Variant: Equatable {
        case information(InformationStyle)
        case notice
        case warning
        case critical

        public enum InformationStyle: Equatable {
            case `default`
            case loud
        }
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

                var symbolName: String {
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
