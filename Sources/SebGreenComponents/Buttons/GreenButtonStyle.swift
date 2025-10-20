//
//  GreenButtonStyle.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-28.
//

import SwiftUI

// Should this be public?
struct GreenButtonStyle: ButtonStyle {
    let kind: GreenButton.Kind
    let size: GreenButton.Size
    
    public func makeBody(configuration: Configuration) -> some View {
        GeometryReader { proxy in // TODO: - Check if this can be achieved with ScaledMetrics
            let minH = GreenButtonTokens.minHeight(for: size)
            let corner = GreenButtonTokens.cornerRadius(forHeight: minH)
            let bgColors = GreenButtonTokens.background(for: kind)
            let fgColors = GreenButtonTokens.foreground(for: kind)
            let border = GreenButtonTokens.border(for: kind)
            let padding = GreenButtonTokens.paddings(for: size)
            
            // pressed/disabled state derived colors
            let isPressed = configuration.isPressed
            let state = ButtonVisualState(isPressed: isPressed)
            
            configuration.label
                .padding(.horizontal, padding.h)
                .padding(.vertical, padding.v)
                .frame(minHeight: minH)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: corner)
                        .fill(bgColors.color(for: state))
                        .overlay(content: {
                            if isPressed {
                                RoundedRectangle(cornerRadius: corner)
                                    .fill(
                                        GreenButtonTokens.pressedOverlay(for: kind)
                                    )
                            }
                        })
                )
                .overlay(
                    RoundedRectangle(cornerRadius: corner)
                        .strokeBorder(border?.color(for: state) ?? .clear, lineWidth: border?.width ?? 0)
                )
                .foregroundStyle(fgColors.color(for: state))
                .animation(.easeInOut(duration: 0.16), value: isPressed)
            // Maintain single-line radius even if height grows due to wrapping: clamp radius to single-line baseline
                .modifier(DynamicCornerRadius(baseCorner: corner))
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
        .frame(minHeight: GreenButtonTokens.minHeight(for: size))
        .fixedSize(horizontal: false, vertical: true) // allows wrapping to increase height
    }
}

private struct DynamicCornerRadius: ViewModifier {
    var baseCorner: CGFloat
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { g in
                Color.clear
                    .clipShape(RoundedRectangle(cornerRadius: baseCorner))
            })
    }
}
