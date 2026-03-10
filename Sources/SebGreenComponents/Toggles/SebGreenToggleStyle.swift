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
    private let activeColor: Color = .l3Positive01
    private let inactiveColor: Color = .l3Neutral03
    private let width: CGFloat = 51
    private let height: CGFloat = 31
    private let circlePadding: CGFloat = 2
    private let offset: CGFloat = 10

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .typography(.detailBookM)
                .foregroundColor(.contentNeutral01)

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

/// This was introduced with the idea of overiding only the colors but keeping the native system animations, and also the native disabled styling. However that does not work. The colors are applied but the native liquid glass blob when we drag is gone, and it also does not show up on tap.
struct GreenNativeToggleStyle: ToggleStyle {
    private let onColor: Color = .l3Positive01
    private let offColor: Color = .l3Neutral03
    
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            
            // The Switch Background
            if #available(iOS 26.0, *) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(configuration.isOn ? onColor : offColor)
                    .opacity(isEnabled ? 1.0 : 0.5) // Handle disabled state color
                    .frame(width: 51, height: 31)
                    .overlay(
                        // The Sliding Thumb
                        Circle()
                            .fill(.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .glassEffect(.regular.tint(configuration.isOn ? onColor : offColor))
                    .onTapGesture {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                            configuration.isOn.toggle()
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(configuration.isOn ? onColor : offColor)
                    .opacity(isEnabled ? 1.0 : 0.5) // Handle disabled state color
                    .frame(width: 51, height: 31)
                    .overlay(
                        // The Sliding Thumb
                        Circle()
                            .fill(.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }
}


#Preview {
    struct Preview: View {
        @State var isOn = false
        var body: some View {
            VStack {
                Toggle("System Enabled", isOn: $isOn)
                Toggle("System On Disabled", isOn: .constant(true))
                    .disabled(true)
                Toggle("System Off Disabled", isOn: .constant(false))
                    .disabled(true)
                
                Divider()
                    .padding(40)
                
                Toggle("System Stylised Enabled", isOn: $isOn)
                    .tint(Color.l3Positive01)
                
                Toggle("System Stylised On Disabled", isOn: .constant(true))
                    .tint(Color.l3Positive01)
                    .disabled(true)
                
                Toggle("System Stylised Off Disabled", isOn: .constant(false))
                    .tint(Color.l3Positive01)
                    .disabled(true)
                
                Divider()
                    .padding(40)
                
                Toggle("SEB Green Enabled", isOn: $isOn)
                    .toggleStyle(SebGreenToggleStyle())
                
                Toggle("SEB Green On Disabled", isOn: .constant(true))
                    .toggleStyle(SebGreenToggleStyle())
                
                Toggle("SEB Green Off Disabled", isOn: .constant(false))
                    .toggleStyle(SebGreenToggleStyle())
                
                Divider()
                    .padding(40)
                
                Toggle("Green Enabled", isOn: $isOn)
                    .toggleStyle(GreenNativeToggleStyle())
                
                Toggle("Green On Disabled", isOn: .constant(true))
                    .toggleStyle(GreenNativeToggleStyle())
                
                Toggle("Green Off Disabled", isOn: .constant(false))
                    .toggleStyle(GreenNativeToggleStyle())
            }
            .padding(8)
        }
    }

    return Preview()
}
