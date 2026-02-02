//
//  GreenButtonTokens.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-28.
//

import SwiftUI
import GdsKit

struct ButtonVisualState {
    let isPressed: Bool
}

struct StateColors {
    let normal: Color
    let pressed: Color
    let disabled: Color
    
    func color(for state: ButtonVisualState) -> Color {
        state.isPressed ? pressed : normal
    }
}

struct StateBorder {
    let normal: Color
    let pressed: Color
    let disabled: Color
    let width: CGFloat
    
    func color(for state: ButtonVisualState) -> Color {
        state.isPressed ? pressed : normal
    }
}

enum GreenButtonTokens {
    // Heights
    static func minHeight(for size: GreenButton.Size) -> CGFloat {
        switch size {
        case .xLarge: return 56
        case .large: return 48
        case .medium: return 40
        case .small: return 32
        }
    }
    
    static func typography(for size: GreenButton.Size) -> Typography {
        switch size {
        case .xLarge, .large, .medium:
            return .detailBookM
        case .small:
            return .detailBookS
        }
    }
    
    static func paddings(for size: GreenButton.Size) -> (h: CGFloat, v: CGFloat) {
        switch size {
        case .xLarge: return (.spaceXl, .spaceL)
        case .large: return (.spaceXl, .spaceS)
        case .medium: return (.spaceL, .spaceS)
        case .small: return (.spaceM, .spaceS)
        }
    }
    
    static func cornerRadius(forHeight height: CGFloat) -> CGFloat {
        height / 2
    }
    
    static func background(for kind: GreenButton.Kind) -> StateColors {
        switch kind {
        case .brand:
            return StateColors(
                normal: .l3Brand01,
                pressed: .l3Brand01,
                disabled: .l3Disabled03
            )
        case .primary:
            return StateColors(
                normal: .l3NeutralStrong,
                pressed: .stateDarkButtons,
                disabled: .l3Disabled03
            )
        case .secondary: // TODO: Needs to change state colors for different background and context
            return StateColors(
                normal: .l3Neutral02,
                pressed: .stateOnPress,
                disabled: .l3Disabled03
            )
        case .tertiary:
            return StateColors(
                normal: .clear,
                pressed: .stateNeutral05,
                disabled: .l3Disabled03
            )
        case .outline:
            return StateColors(
                normal: .clear,
                pressed: .stateNeutral05,
                disabled: .l3Disabled03
            )
        case .negative:
            return StateColors(
                normal: .l3Negative01,
                pressed: .stateNegative01,
                disabled: .l3Disabled03
            )
        }
    }
    
    static func pressedOverlay(for kind: GreenButton.Kind) -> Color {
        switch kind {
        case .brand: return .stateBrand01
        case .primary: return .stateDarkButtons
        case .secondary: return .stateOnPress
        case .tertiary, .outline: return .stateNeutral05
        case .negative: return .stateNegative01
        }
    }
    
    static func foreground(for kind: GreenButton.Kind) -> StateColors {
        switch kind {
        case .brand, .primary:
            return StateColors(
                normal: .contentNeutral03,
                pressed: .contentNeutral03,
                disabled: .contentDisabled01
            )
        case .secondary, .tertiary:
            return StateColors(
                normal: .contentNeutral01,
                pressed: .contentNeutral01,
                disabled: .contentDisabled01
            )
        case .outline:
            return StateColors(
                normal: .contentNeutral01,
                pressed: .contentNeutral01,
                disabled: .contentDisabled01
            )
        case .negative:
            return StateColors(
                normal: .contentInversed,
                pressed: .contentInversed,
                disabled: .contentDisabled01
            )
        }
    }
    
    static func border(for kind: GreenButton.Kind) -> StateBorder? {
        switch kind {
        case .outline:
            return StateBorder(
                normal: .borderSubtle01,
                pressed: .borderSubtle01,
                disabled: .clear,
                width: 1
            )
        default:
            return nil
        }
    }
}
