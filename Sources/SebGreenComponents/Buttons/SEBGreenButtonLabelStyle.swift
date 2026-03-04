import SwiftUI

struct SEBGreenButtonLabelStyle: LabelStyle {
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

extension LabelStyle where Self == SEBGreenButtonLabelStyle {
    static var buttonLabelStyle: SEBGreenButtonLabelStyle {
        SEBGreenButtonLabelStyle()
    }
    
    static func seb(_ style: SEBGreenButtonLabelStyle) -> some LabelStyle  {
        style
    }
}
