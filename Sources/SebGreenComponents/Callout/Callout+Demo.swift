import SwiftUI

public struct CalloutDemo: View {
    @State private var cardIsClickable = false
    @State private var showActionButton = true
    @State private var showCloseButton = true
    @State private var surface: Surface = .neutral02
    @State private var dismissedVariants: Set<Callout.Variant> = []
    @State private var trigger = false

    public init() {}

    public var body: some View {
        DemoContainer("Callout") {
            configuration
        } content: {
            VStack(spacing: .gds(.spaceM)) {
                callout(
                    "Information (Subtle)",
                    shortText: "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.subtle)
                )

                callout(
                    "Information",
                    shortText: "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.default)
                )

                callout(
                    "Notice",
                    shortText: "Used for important but not urgent information that needs attention.",
                    variant: .notice
                )

                callout(
                    "Warning",
                    shortText: "Used for situations that may cause issues if not addressed.",
                    variant: .warning
                )

                callout(
                    "Critical",
                    shortText: "Used for urgent situations that require immediate action.",
                    variant: .critical
                )

                if !dismissedVariants.isEmpty {
                    Button {
                        withAnimation {
                            dismissedVariants.removeAll()
                        }
                    } label: {
                        Label("Restore dismissed", systemImage: "arrow.counterclockwise")
                    }
                    .buttonStyle(.bordered)
                    .padding(.top, .gds(.spaceS))
                }
            }
        }
        .surface(surface)
    }

    @ViewBuilder
    private func callout(
        _ title: String,
        shortText: String,
        variant: Callout.Variant
    ) -> some View {
        if !dismissedVariants.contains(variant) {
            let callout = Callout(
                title,
                shortText: shortText,
                action: showActionButton
                    ? .init(title: "See details", linkStyle: .internalLink, action: {})
                    : nil,
                onClose: showCloseButton
                    ? { withAnimation { _ = dismissedVariants.insert(variant) } }
                    : nil
            )
            .calloutStyle(variant)
            .id(variant)
            .transition(.opacity)

            if cardIsClickable {
                Button {
                    trigger.toggle()
                } label: {
                    callout
                }
                .buttonStyle(.plain)
                .sensoryFeedbackIfAvailable(.error, trigger: trigger)
            } else {
                callout
            }
        }
    }

    private var configuration: some View {
        VStack(spacing: .gds(.spaceL)) {
            DemoSection("General settings") {
                Toggle(
                    "Action button",
                    isOn: $showActionButton.animation()
                )
                Toggle(
                    "Close button",
                    isOn: $showCloseButton.animation()
                )

                VStack(spacing: .gds(.spaceL)) {
                    Divider()

                    Toggle(
                        isOn: $cardIsClickable
                    ) {
                        Text("Card clickable")
                        Text("Makes the card clickable. This will trigger error haptic feedback.")
                    }
                }
            }

            Divider()

            DemoSection("Parent background") {
                Picker(
                    "Surface",
                    selection: $surface.animation()
                ) {
                    Text("Neutral 01")
                        .tag(Surface.neutral01)
                    Text("Neutral 02")
                        .tag(Surface.neutral02)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.gds(.spaceM))
    }
}

#Preview {
    NavigationStack {
        CalloutDemo()
            .previewByRegisteringFonts()
    }
}
