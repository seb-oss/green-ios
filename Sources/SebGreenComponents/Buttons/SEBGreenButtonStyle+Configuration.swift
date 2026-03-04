import SwiftUI

// MARK: - Configuration

public extension SEBGreenButtonStyle {
    struct Configuration {
        let background: StatefulStyle
        let foreground: StatefulStyle
        let stroke: StatefulStroke?
        
        public init(
            background: StatefulStyle,
            foreground: StatefulStyle,
            stroke: StatefulStroke? = nil
        ) {
            self.background = background
            self.foreground = foreground
            self.stroke = stroke
        }
    }
}
