import SwiftUI

@available(iOS 16.0, *)
public struct InputFieldDemo: View {
    @State private var isOptional = false
    @State private var supportTextEnabled = false
    @State private var presentInfoButton = true
    @State private var expandTextArea = false

    @State private var surface: Surface = .neutral02

    @State private var defaultText = ""
    @State private var floatingText = ""
    @State private var amount: Decimal?

    @State private var maxCharacterRuleEnabled = true
    @State private var maxCharacters = 25
    @State private var ruleEnforcement: MaxCharacterRule.Enforcement = .soft

    @FocusState private var focusedField: Field?

    private enum Field: Hashable {
        case defaultField
        case floatingField
        case amountField
    }

    public init() {}

    public var body: some View {
        ScrollViewReader { proxy in
            DemoContainer("InputField", contentPadding: .zero) {
                configuration
            } content: {
                VStack(spacing: .spaceXl) {
                    InputField("Default Label", text: $defaultText) {
                        if presentInfoButton {
                            Button(systemName: "info.circle") {}
                        }
                    }
                    .applyRules(
                        to: $defaultText,
                        rules: .maxCharacters(
                            maxCharacters,
                            enforcement: ruleEnforcement
                        ),
                        isEnabled: maxCharacterRuleEnabled
                    )
                    .supportiveText(
                        supportTextEnabled ? "Lorem Ipsum support text" : nil
                    )
                    .scrollFocusField(
                        focusedField: $focusedField,
                        equals: .defaultField
                    )

                    Divider()

                    InputField("Floating Label", text: $floatingText)
                        .inputFieldStyle(.floating)
                        .applyRules(
                            to: $floatingText,
                            rules: .maxCharacters(
                                maxCharacters,
                                enforcement: ruleEnforcement
                            ),
                            isEnabled: maxCharacterRuleEnabled
                        )
                        .scrollFocusField(
                            focusedField: $focusedField,
                            equals: .floatingField
                        )

                    Divider()

                    InputField(
                        "Formatted Input field",
                        value: $amount,
                        format: .currency(code: "SEK")
                    )
                    .supportiveText(supportTextEnabled ? "Fill in amount" : nil)
                    .keyboardType(.decimalPad)
                    .scrollFocusField(
                        focusedField: $focusedField,
                        equals: .amountField
                    )
                }
                .optionalField(isOptional)
                .expandTextArea(expandTextArea ? 4... : 1...)
                .padding(.spaceM)
                .surface(surface)
                .onChange(of: focusedField) { focusedField in
                    withAnimation {
                        proxy.scrollTo(focusedField, anchor: .center)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }

    private var configuration: some View {
        VStack(spacing: .spaceL) {
            DemoSection("General settings") {
                Toggle(
                    "Optional",
                    isOn: $isOptional.animation()
                )
                Toggle(
                    "Support text",
                    isOn: $supportTextEnabled.animation()
                )
                Toggle(
                    "Present info button",
                    isOn: $presentInfoButton.animation()
                )
                Toggle(
                    "Expand text area",
                    isOn: $expandTextArea.animation()
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

            Divider()

            DemoSection("Rules") {
                Toggle(
                    "Enable max character rule",
                    isOn: $maxCharacterRuleEnabled.animation()
                )

                if maxCharacterRuleEnabled {
                    Stepper(
                        "Max Characters: \(maxCharacters)",
                        value: $maxCharacters,
                        in: 1...100,
                        step: 1
                    )

                    Picker("", selection: $ruleEnforcement) {
                        Text("Soft Limit")
                            .tag(MaxCharacterRule.Enforcement.soft)
                        Text("Hard Limit")
                            .tag(MaxCharacterRule.Enforcement.hard)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .padding(.spaceM)
    }
}

@available(iOS 16.0, *)
#Preview {
    NavigationStack {
        InputFieldDemo()
    }
}
