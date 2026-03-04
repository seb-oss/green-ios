import SwiftUI
import GdsKit

extension SEBGreenButtonStyle.Configuration {
    static let primary = Self(
        background: StatefulStyle(
            normal: Color.l3NeutralStrong,
            pressed: Color.stateDarkButtons,
            disabled: Color.l3Disabled03
        ),
        foreground: StatefulStyle(
            normal: Color.contentNeutral03,
            disabled: Color.contentDisabled01
        )
    )
    
    static let secondary = Self(
        background: StatefulStyle(
            normal: LevelBasedColor { level in level.colors.neutral01 },
            pressed: Color.stateOnPress,
            disabled: Color.l3Disabled03
        ),
        foreground: StatefulStyle(
            normal: Color.contentNeutral01,
            disabled: Color.contentDisabled01
        )
    )
    
    static let tertiary = Self(
        background: StatefulStyle(
            normal: Color.clear,
            pressed: Color.stateNeutral05,
            disabled: Color.l3Disabled03
        ),
        foreground: StatefulStyle(
            normal: Color.contentNeutral01,
            disabled: Color.contentDisabled01
        )
    )
    
    static let outline = Self(
        background: StatefulStyle(
            normal: Color.clear,
            pressed: Color.stateNeutral05,
            disabled: Color.l3Disabled03
        ),
        foreground: StatefulStyle(
            normal: Color.contentNeutral01,
            disabled: Color.contentDisabled01
        ),
        stroke: StatefulStroke(
            normal: Stroke(
                style: StrokeStyle(lineWidth: 1),
                color: Color.borderSubtle01
            ),
            disabled: nil
        )
    )
    
    static let negative = Self(
        background: StatefulStyle(
            normal: Color.l3Negative01,
            pressed: Color.stateNegative01,
            disabled: Color.l3Disabled03
        ),
        foreground: StatefulStyle(
            normal: Color.contentInversed,
            disabled: Color.contentDisabled01
        )
    )
}
