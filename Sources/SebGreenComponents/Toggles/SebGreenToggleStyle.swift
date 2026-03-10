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
    private let width: CGFloat = 64
    private let height: CGFloat = 28
    private let circlePadding: CGFloat = 2
    private let offset: CGFloat = 10

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .typography(.detailBookM)
                .foregroundColor(.contentNeutral01)

            Spacer()

            if #available(iOS 26.0, *) {
                Capsule(style: .continuous)
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
                    .glassEffect()
            } else {
                Capsule(style: .continuous)
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
    }

    private func circle(isOn: Bool) -> some View {
        Capsule(style: .continuous)
            .frame(width: 39, height: 24)
            .foregroundStyle(Color.white)
            .padding(.vertical, circlePadding)
            .cornerRadius(12)
            .offset(x: isOn ? offset : -offset)
            
    }
}

#if os(iOS)
import UIKit

/// A UIKit-backed switch that preserves native animations and effects while allowing custom colors.
struct SystemSwitchView: UIViewRepresentable {
    @Binding var isOn: Bool
    var onColor: Color
    var offColor: Color
    var isEnabled: Bool

    func makeUIView(context: Context) -> UISwitch {
        let uiSwitch = UISwitch(frame: .zero)
        uiSwitch.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return uiSwitch
    }

    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.isOn = isOn
        uiView.isEnabled = isEnabled

        // Apply custom colors while keeping native look & feel
        uiView.onTintColor = UIColor(onColor) // On-state track color
        uiView.thumbTintColor = nil           // Keep the native thumb appearance

        // Off-state track color trick: use background + rounded corners
        let offUIColor = UIColor(offColor)
        uiView.tintColor = .red
        uiView.backgroundColor = offUIColor
        uiView.clipsToBounds = true

        // Ensure the track remains pill-shaped when off
        let radius = uiView.bounds.height / 2
        if uiView.layer.cornerRadius != radius {
            uiView.layer.cornerRadius = radius
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator {
        var parent: SystemSwitchView
        init(_ parent: SystemSwitchView) { self.parent = parent }
        @objc func valueChanged(_ sender: UISwitch) {
            parent.isOn = sender.isOn
        }
    }
}
#endif

/// This style customizes only the on/off colors while preserving the system's native
/// animations, interactions, and disabled appearance by rendering a real UISwitch on iOS.
///
/// Notes:
/// - On iOS, a UIKit-backed switch is used so the native material/physics are retained.
/// - On other platforms, a simple SwiftUI fallback is used.
struct GreenNativeToggleStyle: ToggleStyle {
    private let onColor: Color = .l3Positive01
    private let offColor: Color = .l3Neutral03

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            SystemSwitchView(
                isOn: configuration.$isOn,
                onColor: onColor,
                offColor: offColor,
                isEnabled: isEnabled
            )
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
                    .disabled(true)
                
                Toggle("SEB Green Off Disabled", isOn: .constant(false))
                    .toggleStyle(SebGreenToggleStyle())
                    .disabled(true)
                
                Divider()
                    .padding(40)
                
                Toggle("Green Enabled", isOn: $isOn)
                    .toggleStyle(GreenNativeToggleStyle())
                
                Toggle("Green On Disabled", isOn: .constant(true))
                    .toggleStyle(GreenNativeToggleStyle())
                    .disabled(true)
                
                Toggle("Green Off Disabled", isOn: .constant(false))
                    .toggleStyle(GreenNativeToggleStyle())
                    .disabled(true)
            }
            .padding(8)
        }
    }

    return Preview()
}
