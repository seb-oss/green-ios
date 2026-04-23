import SwiftUI

@available(iOS 16, *)
public struct CalloutDemo: View {
    @State private var showActionButton = true
    @State private var showCloseButton = true
    @State private var surface: Surface = .neutral02
    @State private var dismissedVariants: Set<Callout.Variant> = []

    public init() {}

    public var body: some View {
        DemoContainer("Callout") {
            configuration
        } content: {
            VStack(spacing: .spaceM) {
                callout(
                    "Information (Subtle)",
                    shortText: "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.subtle)
                )

                callout(
                    "Information (Loud)",
                    shortText: "Used for passive, non-critical updates like tips or background information.",
                    variant: .information(.loud)
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
                    .padding(.top, .spaceS)
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
            Callout(
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
        }
    }

    private var configuration: some View {
        VStack(spacing: .spaceL) {
            DemoSection("General settings") {
                Toggle(
                    "Action button",
                    isOn: $showActionButton.animation()
                )
                Toggle(
                    "Close button",
                    isOn: $showCloseButton.animation()
                )
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
        .padding(.spaceM)
    }
}

@available(iOS 16, *)
#Preview {
    NavigationStack {
        CalloutDemo()
    }
}
