import SwiftUI
import GdsKit

// MARK: - Component Showcase

/// A single view displaying every component in the SebGreenComponents package,
/// split into two segments to avoid nesting scroll views (GreenList owns its own ScrollView).
public struct ComponentShowcase: View {
    enum Segment: String, CaseIterable {
        case components = "Components"
        case lists = "Lists"
    }

    @State private var segment: Segment = .components
    @State private var toggleOn = true
    @State private var toggleOff = false
    @State private var floatingText = ""
    @State private var floatingFilled = "Hello world"
    @State private var floatingError = "Too long"
    @State private var outsideText = ""
    @State private var outsideFilled = "Prefilled"
    @State private var outsideError = "Bad input"

    public var body: some View {
        VStack(spacing: 0) {
            Picker("Section", selection: $segment) {
                ForEach(Segment.allCases, id: \.self) { s in
                    Text(s.rawValue).tag(s)
                }
            }
            .pickerStyle(.segmented)
            .padding(16)

            switch segment {
            case .components:
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        buttonsSection
                        infoCardSection
                        floatingLabelInputSection
                        labelOutsideInputSection
                        toggleSection
                    }
                    .padding(16)
                }
            case .lists:
                greenListSection
            }
        }
        .background(Color.l1Neutral02)
    }

    // MARK: - Buttons

    private var buttonsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Buttons")

            ForEach(
                [GreenButton.Kind.brand, .primary, .secondary, .tertiary, .outline, .negative],
                id: \.rawValue
            ) { kind in
                VStack(alignment: .leading, spacing: 8) {
                    Text(kind.rawValue.capitalized)
                        .typography(.detailRegularS)
                        .foregroundStyle(Color.contentNeutral02)

                    // All sizes
                    ForEach(GreenButton.Size.allCases, id: \.rawValue) { size in
                        GreenButton(title: size.rawValue, kind: kind, size: size, action: {})
                    }

                    // With icons
                    GreenButton(
                        title: "Leading",
                        kind: kind,
                        size: .medium,
                        icon: Image(systemName: "arrow.down.circle"),
                        iconPosition: .leading,
                        action: {}
                    )
                    GreenButton(
                        title: "Trailing",
                        kind: kind,
                        size: .medium,
                        icon: Image(systemName: "arrow.right"),
                        iconPosition: .trailing,
                        action: {}
                    )
                    GreenButton(
                        kind: kind,
                        size: .medium,
                        icon: Image(systemName: "star.fill"),
                        action: {}
                    )

                    // Disabled
                    GreenButton(title: "Disabled", kind: kind, size: .medium, isEnabled: false, action: {})
                }
            }
        }
    }

    // MARK: - Info Cards

    private var infoCardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Info Card")

            InfoCardView(
                model: .init(
                    title: "Information variant",
                    message: "This is an information card with a close button and call-to-action.",
                    variant: .information
                ),
                actions: .init(
                    onClose: {},
                    callToAction: .init(title: "Action", action: {})
                )
            )

            InfoCardView(
                model: .init(
                    title: "Information HD variant",
                    message: "High-contrast card for prominent messages.",
                    variant: .informationHd
                ),
                actions: .init(onClose: {})
            )
        }
    }

    // MARK: - Floating Label Input

    private var floatingLabelInputSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Floating Label Input")

            FloatingLabelInput(
                text: $floatingText,
                placeholder: "Empty input",
                isValid: true
            )

            FloatingLabelInput(
                text: $floatingFilled,
                placeholder: "Filled input",
                characterLimit: 50,
                supportingText: "Supporting text",
                isValid: true
            )

            FloatingLabelInput(
                text: $floatingError,
                placeholder: "Error state",
                characterLimit: 5,
                errorText: "Character limit reached",
                isValid: false
            )
        }
    }

    // MARK: - Label Outside Input

    private var labelOutsideInputSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Label Outside Input")

            LabelOutsideInput(
                text: $outsideText,
                title: "Label",
                placeholder: "Empty input"
            )

            LabelOutsideInput(
                text: $outsideFilled,
                title: "Label",
                placeholder: "Placeholder",
                characterLimit: 50,
                supportingText: "Supporting text"
            )

            LabelOutsideInput(
                text: $outsideError,
                title: "Label",
                placeholder: "Placeholder",
                characterLimit: 5,
                errorText: "Too many characters",
                isValid: false
            )
        }
    }

    // MARK: - Toggle

    private var toggleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Toggle")

            Toggle("Enabled toggle (on)", isOn: $toggleOn)
                .toggleStyle(SebGreenToggleStyle())

            Toggle("Enabled toggle (off)", isOn: $toggleOff)
                .toggleStyle(SebGreenToggleStyle())
        }
    }

    // MARK: - Green List / Rows

    private var greenListSection: some View {
        GreenList(style: .grouped) {
                GreenRow(
                    title: "Title only",
                    trailing: .chevron,
                    onTap: {}
                )
                GreenRow(
                    title: "With subtitle",
                    subtitle: "Subtitle text",
                    leading: .icon(Image(systemName: "doc.plaintext")),
                    trailing: .chevron,
                    size: .list72,
                    onTap: {}
                )
                GreenRow(
                    title: "Value text",
                    leading: .icon(Image(systemName: "creditcard")),
                    trailing: .valueText("1 234 kr"),
                    size: .list72,
                    onTap: {}
                )
                GreenRow(
                    title: "Trailing icon",
                    leading: .icon(Image(systemName: "person.fill")),
                    trailing: .icon(Image(systemName: "info.circle")),
                    onTap: {}
                )
                GreenRow(
                    title: "Toggle row",
                    leading: .icon(Image(systemName: "bell.fill")),
                    trailing: .toggle(isOn: $toggleOn)
                )
                GreenRow(
                    title: "Checkbox selected",
                    leading: .checkbox(isSelected: true),
                    isSelected: true,
                    onTap: {}
                )
                GreenRow(
                    title: "Radio selected",
                    leading: .radio(isSelected: true),
                    isSelected: true,
                    onTap: {}
                )
                GreenRow(
                    title: "Disabled row",
                    subtitle: "Not available",
                    leading: .icon(Image(systemName: "lock.fill")),
                    isEnabled: false,
                    showsSeparator: false,
                    onTap: {}
                )
            }
    }

    // MARK: - Helpers

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .typography(.bodyMediumM)
            .foregroundStyle(Color.contentNeutral01)
    }
}

// MARK: - Previews

#Preview("All Components") {
    ComponentShowcase()
}

#Preview("Dark Mode") {
    ComponentShowcase()
        .preferredColorScheme(.dark)
}

#Preview("Dynamic Type - XS") {
    ComponentShowcase()
        .dynamicTypeSize(.xSmall)
}

#Preview("Dynamic Type - Default") {
    ComponentShowcase()
        .dynamicTypeSize(.large)
}

#Preview("Dynamic Type - XL") {
    ComponentShowcase()
        .dynamicTypeSize(.xLarge)
}

#Preview("Dynamic Type - XXXL") {
    ComponentShowcase()
        .dynamicTypeSize(.xxxLarge)
}

#Preview("Dynamic Type - AX1") {
    ComponentShowcase()
        .dynamicTypeSize(.accessibility1)
}

#Preview("Dynamic Type - AX3") {
    ComponentShowcase()
        .dynamicTypeSize(.accessibility3)
}

#Preview("Dynamic Type - AX5") {
    ComponentShowcase()
        .dynamicTypeSize(.accessibility5)
}

#Preview("Dark + AX1") {
    ComponentShowcase()
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.accessibility1)
}
