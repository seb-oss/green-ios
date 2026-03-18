import SwiftUI

public extension Level {
    struct Colors {
        public let neutral01: Color
        public let neutral02: Color
        public let neutralStrong: Color?
        public let neutralTone: Color?
        public let neutralLoud: Color?
        public let brand01: Color?
        public let negative01: Color?
        public let disabled03: Color?
    }
    
    var colors: Colors {
        switch self {
        case .level1:
            Colors(
                neutral01: .l1Neutral01,
                neutral02: .l1Neutral02,
                neutralStrong: nil,
                neutralTone: nil,
                neutralLoud: nil,
                brand01: nil,
                negative01: nil,
                disabled03: nil
            )
        case .level2:
            Colors(
                neutral01: .l2Neutral01,
                neutral02: .l2Neutral02,
                neutralStrong: nil,
                neutralTone: nil,
                neutralLoud: .l2NeutralLoud,
                brand01: nil,
                negative01: nil,
                disabled03: nil
            )
        case .level3:
            Colors(
                neutral01: .l3Neutral01,
                neutral02: .l3Neutral02,
                neutralStrong: .l3NeutralStrong,
                neutralTone: .l3NeutralTone,
                neutralLoud: nil,
                brand01: .l3Brand01,
                negative01: .l3Negative01,
                disabled03: .l3Disabled03
            )
        }
    }
}
