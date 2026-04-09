import SwiftUI

struct GreenLabelStyle: LabelStyle {
    @Environment(\.buttonIconPosition) private var iconPosition
    @Environment(\.buttonIconSpacing) private var iconSpacing
    
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
    static var buttonLabelStyle: GreenLabelStyle {
        GreenLabelStyle()
    }
    
    static func seb(_ style: GreenLabelStyle) -> some LabelStyle  {
        style
    }
}
