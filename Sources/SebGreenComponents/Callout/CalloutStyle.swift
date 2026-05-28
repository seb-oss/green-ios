import SwiftUI

public struct CalloutStyle {
    let backgroundColor: AnyShapeStyle
    let borderColor: Color
    let iconColor: Color
    let textColor: Color
    let severityIcon: Icon?
    
    struct Icon {
        let iconSystemName: String
        let accessibilitySeverityLabel: String
    }
}
