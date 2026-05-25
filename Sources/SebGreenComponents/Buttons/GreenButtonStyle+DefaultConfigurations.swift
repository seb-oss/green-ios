import SwiftUI
import GdsKit

extension GreenButtonStyle.Configuration {
    static let primary = Self(
        background: StatefulStyle(
            normal: .gds(.l3Neutral03),
            pressed: .gds(.stateNeutral02),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral03),
            disabled: .gds(.contentDisabled01)
        )
    )

    static let secondary = Self(
        background: StatefulStyle(
            normal: .surfaceAware,
            pressed: .gds(.stateNeutral06),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral01),
            disabled: .gds(.contentDisabled01)
        )
    )

    static let tertiary = Self(
        background: StatefulStyle(
            normal: Color.clear,
            pressed: .gds(.stateNeutral05),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral01),
            disabled: .gds(.contentDisabled01)
        )
    )

    static let outline = Self(
        background: StatefulStyle(
            normal: Color.clear,
            pressed: .gds(.stateNeutral05),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral01),
            disabled: .gds(.contentDisabled01)
        ),
        stroke: StatefulStroke(
            normal: Stroke(
                style: StrokeStyle(lineWidth: 1),
                color: .gds(.borderNeutral02)
            ),
            disabled: nil
        )
    )

    static let negative = Self(
        background: StatefulStyle(
            normal: .gds(.l3Negative01),
            pressed: .gds(.stateNegative01),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral05),
            disabled: .gds(.contentDisabled01)
        )
    )

    static let notice = Self(
        background: StatefulStyle(
            normal: .gds(.l3Notice01),
            pressed: .gds(.stateNotice02),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral05),
            disabled: .gds(.contentDisabled01)
        )
    )

    static let tonal = Self(
        background: StatefulStyle(
            normal: .gds(.l3Tonal01, bundle: .module),
            pressed: .gds(.stateTonal01, bundle: .module),
            disabled: .gds(.l3Disabled03)
        ),
        foreground: StatefulStyle(
            normal: .gds(.contentNeutral05),
            disabled: .gds(.contentDisabled01)
        )
    )
}
