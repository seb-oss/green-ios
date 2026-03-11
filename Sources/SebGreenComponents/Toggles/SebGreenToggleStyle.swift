//
//  SebToggleStyle.swift
//  SebGreen
//

import SwiftUI

/// A ToggleStyle that draws a branded capsule switch entirely in SwiftUI.
/// - Note: Changing the size of the inner thumb is not supported.
/// - This style overrides the font and foreground color of the Toggle's label.
public struct GreenCapsuleToggleStyle: ToggleStyle {

    private let onTrackColor: Color = .l3Positive01
    private let offTrackColor: Color = .l3Neutral03

    private let trackWidth: CGFloat = 64
    private let trackHeight: CGFloat = 28

    private let thumbVerticalPadding: CGFloat = 2
    private let thumbHorizontalOffset: CGFloat = 10

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .typography(.detailBookM)
                .foregroundColor(.contentNeutral01)

            Spacer()

            if #available(iOS 26.0, *) {
                Capsule(style: .continuous)
                    .fill(configuration.isOn ? onTrackColor : offTrackColor)
                    .overlay {
                        thumb(isOn: configuration.isOn)
                    }
                    .frame(width: trackWidth, height: trackHeight)
                    .clipped()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            configuration.isOn.toggle()
                        }
                    }
                    .glassEffect()
            } else {
                Capsule(style: .continuous)
                    .fill(configuration.isOn ? onTrackColor : offTrackColor)
                    .overlay {
                        thumb(isOn: configuration.isOn)
                    }
                    .frame(width: trackWidth, height: trackHeight)
                    .clipped()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }

    private func thumb(isOn: Bool) -> some View {
        Capsule(style: .continuous)
            .frame(width: 39, height: 24)
            .foregroundStyle(Color.white)
            .padding(.vertical, thumbVerticalPadding)
            .cornerRadius(12)
            .offset(x: isOn ? thumbHorizontalOffset : -thumbHorizontalOffset)
    }
}

public typealias SebGreenToggleStyle = GreenCapsuleToggleStyle

#if os(iOS)
import UIKit

/// A UIKit-backed UISwitch wrapped for SwiftUI that preserves native animations and effects while allowing custom track colors.
struct UIKitSwitchView: UIViewRepresentable {
    @Binding var isOn: Bool
    var onTrackColor: Color
    var offTrackColor: Color
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
        uiView.onTintColor = UIColor(onTrackColor) // On-state track color
        uiView.thumbTintColor = nil                // Keep the native thumb appearance

        // Off-state track color: use tint/background + rounded corners
        let offUIColor = UIColor(offTrackColor)
        uiView.tintColor = offUIColor
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
        var parent: UIKitSwitchView
        init(_ parent: UIKitSwitchView) { self.parent = parent }
        @objc func valueChanged(_ sender: UISwitch) {
            parent.isOn = sender.isOn
        }
    }
}

// Backward compatibility for old references
typealias SystemSwitchView = UIKitSwitchView
#endif

/// ToggleStyle that renders a real UISwitch to preserve system animations/effects, while allowing custom track colors.
struct SystemSwitchToggleStyle: ToggleStyle {
    private let onTrackColor: Color = .l3Positive01
    private let offTrackColor: Color = .l3Neutral03

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            UIKitSwitchView(
                isOn: configuration.$isOn,
                onTrackColor: onTrackColor,
                offTrackColor: offTrackColor,
                isEnabled: isEnabled
            )
        }
    }
}

typealias GreenNativeToggleStyle = SystemSwitchToggleStyle


#Preview {
    struct Preview: View {
        @State var isOn = false
        var body: some View {
            VStack {
                Toggle("System toggle — Enabled (default renderer)", isOn: $isOn)
                Toggle("System toggle — Disabled (On) (default renderer)", isOn: .constant(true))
                    .disabled(true)
                Toggle("System toggle — Disabled (Off) (default renderer)", isOn: .constant(false))
                    .disabled(true)

                Divider()
                    .padding(40)

                Toggle("System toggle with .tint — Enabled (brand on color)", isOn: $isOn)
                    .tint(Color.l3Positive01)

                Toggle("System toggle with .tint — Disabled (On)", isOn: .constant(true))
                    .tint(Color.l3Positive01)
                    .disabled(true)

                Toggle("System toggle with .tint — Disabled (Off)", isOn: .constant(false))
                    .tint(Color.l3Positive01)
                    .disabled(true)

                Divider()
                    .padding(40)

                Toggle("SwiftUI capsule ToggleStyle — Enabled (custom-drawn)", isOn: $isOn)
                    .toggleStyle(SebGreenToggleStyle())

                Toggle("SwiftUI capsule ToggleStyle — Disabled (On)", isOn: .constant(true))
                    .toggleStyle(SebGreenToggleStyle())
                    .disabled(true)

                Toggle("SwiftUI capsule ToggleStyle — Disabled (Off)", isOn: .constant(false))
                    .toggleStyle(SebGreenToggleStyle())
                    .disabled(true)

                Divider()
                    .padding(40)

                Toggle("UISwitch-backed ToggleStyle — Enabled (preserves native animations)", isOn: $isOn)
                    .toggleStyle(GreenNativeToggleStyle())

                Toggle("UISwitch-backed ToggleStyle — Disabled (On)", isOn: .constant(true))
                    .toggleStyle(GreenNativeToggleStyle())
                    .disabled(true)

                Toggle("UISwitch-backed ToggleStyle — Disabled (Off)", isOn: .constant(false))
                    .toggleStyle(GreenNativeToggleStyle())
                    .disabled(true)
            }
            .padding(8)
        }
    }

    return Preview()
}
