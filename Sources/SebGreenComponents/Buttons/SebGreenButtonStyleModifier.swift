//
//  ButtonStyleModifier.swift
//  SebGreenComponents
//

import SwiftUI

public enum SebGreenButtonStyle {
    case primary
    case secondary
    case tertiary

    fileprivate var backgroundColor: Color {
        switch self {
        case .primary:
            Colors.Level.L3.Background.primary
        case .secondary:
            Colors.Level.L3.Background.secondary
        case .tertiary:
            Color.clear
        }
    }

    fileprivate var foregroundColor: Color {
        switch self {
        case .primary:
            Colors.Level.L3.Content.primary
        case .secondary:
            Colors.Level.L3.Content.tertiary
        case .tertiary:
            Colors.Level.L3.Content.tertiary
        }
    }

    fileprivate var focusColor: Color {
        switch self {
        case .primary:
            Colors.PocCustom.grey28
        case .secondary:
            Colors.PocCustom.grey9
        case .tertiary:
            Colors.PocCustom.grey6
        }
    }
}

fileprivate struct SebGreenButtonStyleModifier: ViewModifier {
    private var style: SebGreenButtonStyle

    @State private var isPressed: Bool = false
    @ScaledMetric private var cornerRadius: CGFloat = 24

    init(style: SebGreenButtonStyle) {
        self.style = style
    }
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(StateHookButtonStyle { isPressed in
                withAnimation(.easeOut) {
                    self.isPressed = isPressed
                }
            })
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isPressed ? style.focusColor :  style.backgroundColor)
            )
            .foregroundColor(style.foregroundColor)
    }
}

public extension View {
    func greenButtonStyle(_ style: SebGreenButtonStyle) -> some View {
        modifier(SebGreenButtonStyleModifier(style: style))
    }

    func primaryButton() -> some View {
        greenButtonStyle(.primary)
    }

    func secondaryButton() -> some View {
        greenButtonStyle(.secondary)
    }

    func tertiaryButton() -> some View {
        greenButtonStyle(.tertiary)
    }
}
