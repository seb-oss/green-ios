//
//  GreenButtonTokens.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-28.
//

import SwiftUI

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
        case .xLarge: return 52
        case .large: return 44
        case .medium: return 36
        case .small: return 28
        }
    }
    
    static func typography(for size: GreenButton.Size) -> Typography {
        switch size {
        case .xLarge, .large, .medium:
            return .headlineEmphasized
        case .small:
            return .subheadEmphasized
        }
    }
    
    static func paddings(for size: GreenButton.Size) -> (h: CGFloat, v: CGFloat) {
        switch size { case .xLarge: return (20, 12)
        case .large: return (16, 10)
        case .medium: return (14, 8)
        case .small: return (12, 6)
        }
    }
    
    static func cornerRadius(forHeight height: CGFloat) -> CGFloat {
        height / 2
    }
    
    static func background(for kind: GreenButton.Kind) -> StateColors {
        switch kind {
        case .brand:
            return StateColors(
                normal: .L3Brand01,
                pressed: .L3Brand01,
                disabled: .L3Disabled03
            )
        case .primary:
            return StateColors(
                normal: .L3Neutral01,
                pressed: .L3Neutral01,
                disabled: .L3Disabled03
            )
        case .secondary:
            return StateColors(
                normal: .groupedBackgroundTertiary,
                pressed: .groupedBackgroundTertiary,
                disabled: .L3Disabled03
            )
        case .tertiary:
            return StateColors(
                normal: .clear,
                pressed: .clear,
                disabled: .L3Disabled03
            )
        case .outline:
            return StateColors(
                normal: .clear,
                pressed: .clear,
                disabled: .L3Disabled03
            )
        case .negative:
            return StateColors(
                normal: .L3Negative01,
                pressed: .L3Negative01,
                disabled: .L3Disabled03
            )
        }
    }
    
    static func pressedOverlay(for kind: GreenButton.Kind) -> Color {
        switch kind {
        case .brand: return .StateBrand01
        case .primary, .secondary: return .StateNeutral01
        case .tertiary, .outline: return .StateNeutral05
        case .negative: return .StateNegative01
        }
    }
    
    static func foreground(for kind: GreenButton.Kind) -> StateColors {
        switch kind {
        case .brand, .primary, .negative:
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
        }
    }
    
    static func border(for kind: GreenButton.Kind) -> StateBorder? {
        switch kind {
        case .outline:
            return StateBorder(
                normal: .BorderSubtle01,
                pressed: .BorderSubtle01,
                disabled: .clear,
                width: 1
            )
        default:
            return nil
        }
    }
}
