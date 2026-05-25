import GdsKit
import SwiftUI

struct GreenLabelStyle: LabelStyle {
    private let iconPosition: IconPosition
    private let iconSpacing: CGFloat
    
    fileprivate init(
        iconPosition: IconPosition,
        iconSpacing: CGFloat
    ) {
        self.iconPosition = iconPosition
        self.iconSpacing = iconSpacing
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let icon = configuration.icon
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            .accessibilityHidden(true)
        
        HStack(spacing: iconSpacing) {
            if iconPosition == .leading {
                icon
                configuration.title
            } else {
                configuration.title
                icon
            }
        }
    }
}

extension LabelStyle where Self == GreenLabelStyle {
    static func buttonLabelStyle(
        iconPosition: IconPosition = .leading,
        iconSpacing: CGFloat = .gds(.spaceXs)
    ) -> GreenLabelStyle {
        GreenLabelStyle(
            iconPosition: iconPosition,
            iconSpacing: iconSpacing
        )
    }
    
    static func gds(_ style: GreenLabelStyle) -> some LabelStyle  {
        style
    }
}
