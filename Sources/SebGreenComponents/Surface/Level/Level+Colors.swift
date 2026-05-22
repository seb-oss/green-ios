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
                neutral01: .gds(.l1Neutral01),
                neutral02: .gds(.l1Neutral02),
                neutralStrong: nil,
                neutralTone: nil,
                neutralLoud: nil,
                brand01: nil,
                negative01: nil,
                disabled03: nil
            )
        case .level2:
            Colors(
                neutral01: .gds(.l2Neutral01),
                neutral02: .gds(.l2Neutral02),
                neutralStrong: nil,
                neutralTone: nil,
                neutralLoud: .clear,//.l2NeutralLoud,
                brand01: nil,
                negative01: nil,
                disabled03: nil
            )
        case .level3:
            Colors(
                neutral01: .gds(.l3Neutral01),
                neutral02: .gds(.l3Neutral02),
                neutralStrong: .clear,//.l3NeutralStrong,
                neutralTone: .clear,//.l3NeutralTone,
                neutralLoud: nil,
                brand01: .gds(.l3Brand01),
                negative01: .gds(.l3Negative01),
                disabled03: .gds(.l3Disabled03)
            )
        }
    }
}
