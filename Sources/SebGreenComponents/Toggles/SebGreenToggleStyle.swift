//
//  SebToggleStyle.swift
//  SebGreen
//

import SwiftUI

/// A ToggleStyle to use with Toggle views to give them SEB Green styling.
/// * Changing size of the switch subcomponent is not possible.
/// * This style will override the font and foreground color of the Toggle's label.
public struct SebGreenToggleStyle: ToggleStyle {

    private let imageResource: ImageResource = ImageResource(name: "circle-check", bundle: .module)
    private let activeColor: Color = Colors.Level.L3.Background.positive
    private let inactiveColor: Color = Color(.systemGray5)
    private let width: CGFloat = 51
    private let height: CGFloat = 31
    private let circlePadding: CGFloat = 2
    private let offset: CGFloat = 10

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .typography(.headlineEmphasized)
                .foregroundColor(Colors.Level.L2.Content.primary)

            Spacer()

            Capsule(style: .circular)
                .fill(configuration.isOn ? activeColor : inactiveColor)
                .overlay {
                    circle(isOn: configuration.isOn)
                }
                .frame(width: width, height: height)
                .clipped()
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }

    private func circle(isOn: Bool) -> some View {
        Circle()
            .fill(.white)
            .padding(.vertical, circlePadding)
            .overlay {
                Image(imageResource)
                    .opacity(isOn ? 1 : 0)
                    .foregroundColor(isOn ? activeColor : inactiveColor)
            }
            .shadow(color: Color.black.opacity(0.07), radius: 2, x: 2, y: 2)
            .offset(x: isOn ? offset : -offset)
    }
}

#Preview {
    struct Preview: View {
        @State var isOn = false
        var body: some View {
            VStack {
                Toggle("System", isOn: $isOn)
                Toggle("SEB Green", isOn: $isOn)
                    .toggleStyle(SebGreenToggleStyle())
            }
            .padding(8)
        }
    }

    return Preview()
}
