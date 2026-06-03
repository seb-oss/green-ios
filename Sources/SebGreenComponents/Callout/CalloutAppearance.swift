import SwiftUI

struct CalloutAppearance {
    let backgroundColor: AnyShapeStyle
    var borderColor: Color = .clear
    var iconColor: Color = .white
    var textColor: Color = .white
    let severityIcon: Icon?
    var primaryActionStyle: GreenButtonStyle = .tonal(
        dimensions: .small,
        iconPosition: .trailing
    )
    var closeButtonColors: (Surface) -> CloseButtonColors = { _ in
        .init(
            primary: .gds(.contentNeutral05),
            secondary: .gds(.l3Tonal01, bundle: .module)
        )
    }

    struct Icon {
        let iconSystemName: String
        let accessibilitySeverityLabel: String
    }

    struct CloseButtonColors {
        let primary: Color
        let secondary: Color
    }
}
