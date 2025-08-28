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
                .L3Neutral01
        case .secondary:
                .backgroundSecondary
        case .tertiary:
            Color.clear
        }
    }

    fileprivate var foregroundColor: Color {
        switch self {
        case .primary:
                .content03
        case .secondary:
                .content01
        case .tertiary:
                .content02
        }
    }

    fileprivate var focusColor: Color {
        backgroundColor.opacity(0.75)
        // TODO: Currently being finalized/revised. Replaced with alpha effect meanwhile
//        switch self {
//        case .primary:
//                .backgroundPrimary
//        case .secondary:
//                .backgroundPrimary
//        case .tertiary:
//                .backgroundPrimary
//        }
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
