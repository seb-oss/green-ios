import SwiftUI

public extension Level {
    /// The resolved GDS color tokens for a given surface level.
    ///
    /// Non-optional properties are available on every level. Optional properties are
    /// `nil` on levels where the token does not exist in the design system:
    /// - `*012` / `*022` / `*032` variants are absent on level 1.
    /// - Semantic colors (`positive`, `negative`, `warning`, `information`, `notice`) are absent on level 1.
    /// - `*02` / `*03` semantic variants and all `disabled` tokens are absent on levels 1 and 2.
    struct Colors {
        // MARK: - Available on all levels

        public let neutral01: Color
        public let neutral02: Color
        public let neutral03: Color
        public let brand01: Color

        // MARK: - Available on level 2 and above

        public let neutral012: Color?
        public let neutral022: Color?
        public let brand02: Color?
        public let positive01: Color?
        public let negative01: Color?
        public let warning01: Color?
        public let information01: Color?
        public let notice01: Color?

        // MARK: - Available on level 3 only

        public let neutral032: Color?
        public let brand022: Color?
        public let positive02: Color?
        public let positive03: Color?
        public let negative02: Color?
        public let negative03: Color?
        public let notice02: Color?
        public let notice03: Color?
        public let warning02: Color?
        public let warning03: Color?
        public let information02: Color?
        public let information03: Color?
        public let disabled01: Color?
        public let disabled02: Color?
        public let disabled03: Color?
    }

    /// The GDS color tokens resolved for this surface level.
    var colors: Colors {
        switch self {
        case .level1:
            Colors(
                neutral01: .gds(.l1Neutral01),
                neutral02: .gds(.l1Neutral02),
                neutral03: .gds(.l1Neutral03),
                brand01: .gds(.l1Brand01),
                neutral012: nil, neutral022: nil,
                brand02: nil,
                positive01: nil, negative01: nil,
                warning01: nil, information01: nil, notice01: nil,
                neutral032: nil, brand022: nil,
                positive02: nil, positive03: nil,
                negative02: nil, negative03: nil,
                notice02: nil, notice03: nil,
                warning02: nil, warning03: nil,
                information02: nil, information03: nil,
                disabled01: nil, disabled02: nil, disabled03: nil
            )
        case .level2:
            Colors(
                neutral01: .gds(.l2Neutral01),
                neutral02: .gds(.l2Neutral02),
                neutral03: .gds(.l2Neutral03),
                brand01: .gds(.l2Brand01),
                neutral012: .gds(.l2Neutral012),
                neutral022: .gds(.l2Neutral022),
                brand02: .gds(.l2Brand02),
                positive01: .gds(.l2Positive01),
                negative01: .gds(.l2Negative01),
                warning01: .gds(.l2Warning01),
                information01: .gds(.l2Information01),
                notice01: .gds(.l2Notice01),
                neutral032: nil, brand022: nil,
                positive02: nil, positive03: nil,
                negative02: nil, negative03: nil,
                notice02: nil, notice03: nil,
                warning02: nil, warning03: nil,
                information02: nil, information03: nil,
                disabled01: nil, disabled02: nil, disabled03: nil
            )
        case .level3:
            Colors(
                neutral01: .gds(.l3Neutral01),
                neutral02: .gds(.l3Neutral02),
                neutral03: .gds(.l3Neutral03),
                brand01: .gds(.l3Brand01),
                neutral012: .gds(.l3Neutral012),
                neutral022: .gds(.l3Neutral022),
                brand02: .gds(.l3Brand02),
                positive01: .gds(.l3Positive01),
                negative01: .gds(.l3Negative01),
                warning01: .gds(.l3Warning01),
                information01: .gds(.l3Information01),
                notice01: .gds(.l3Notice01),
                neutral032: .gds(.l3Neutral032),
                brand022: .gds(.l3Brand022),
                positive02: .gds(.l3Positive02),
                positive03: .gds(.l3Positive03),
                negative02: .gds(.l3Negative02),
                negative03: .gds(.l3Negative03),
                notice02: .gds(.l3Notice02),
                notice03: .gds(.l3Notice03),
                warning02: .gds(.l3Warning02),
                warning03: .gds(.l3Warning03),
                information02: .gds(.l3Information02),
                information03: .gds(.l3Information03),
                disabled01: .gds(.l3Disabled01),
                disabled02: .gds(.l3Disabled02),
                disabled03: .gds(.l3Disabled03)
            )
        }
    }
}
