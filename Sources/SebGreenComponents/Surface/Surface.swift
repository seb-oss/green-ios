import SwiftUI

/// Tracks which neutral color slot the parent surface uses.
public enum Surface: Sendable {
    case neutral01
    case neutral02

    /// Resolves the background color for the given level.
    public func color(for level: Level) -> Color {
        switch self {
        case .neutral01: level.colors.neutral01
        case .neutral02: level.colors.neutral02
        }
    }
}

extension EnvironmentValues {
    @Entry public var surface: Surface = .neutral02
}
