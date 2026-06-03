extension Callout {
    public enum Variant: Sendable, Hashable {
        case information(InformationStyle)
        case notice
        case warning
        case critical

        public enum InformationStyle: Sendable, Equatable {
            case `default`
            case subtle
        }
    }

    public struct Action {
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
        public let perform: () -> Void

        public init(
            title: String,
            linkStyle: LinkStyle? = nil,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.linkStyle = linkStyle
            self.perform = action
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(linkStyle)
        }
    }
}
