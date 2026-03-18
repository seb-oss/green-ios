import SwiftUI

public enum Level: String, Sendable {
    case level1 = "l1"
    case level2 = "l2"
    case level3 = "l3"
    
    public var above: Self {
        switch self {
        case .level1: return .level2
        case .level2: return .level3
        case .level3: return .level3
        }
    }
    
    public var below: Self {
        switch self {
        case .level1: return .level1
        case .level2: return .level1
        case .level3: return .level2
        }
    }
}

public extension EnvironmentValues {
    @Entry var level: Level = .level1
}
