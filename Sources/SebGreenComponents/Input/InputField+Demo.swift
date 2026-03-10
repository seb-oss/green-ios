import SwiftUI

@available(iOS 16.0, *)
public struct InputFieldDemo: View {
    @State private var isOptional = false
    @State private var supportTextEnabled = false
    @State private var presentInfoButton = true
    @State private var expandTextArea = false

    @State private var textfieldBackground:
        InputFieldStyle.Configuration.Background = .white

    @State private var defaultText = ""
    @State private var floatingText = ""
    @State private var amount: Decimal?

    @State private var maxCharacterRuleEnabled = true
    @State private var maxCharacters = 25
    @State private var ruleEnforcement: MaxCharacterRule.Enforcement = .soft

    public init() {}

    private var defaultLabel: some View {
        InputField("Default Label", text: $defaultText) {
            if presentInfoButton {
                Button(action: {}) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .inputFieldStyle(.default.background(textfieldBackground))
    }

    public var body: some View {
        DemoContainer("InputField", contentPadding: .zero) {
            configuration
        } content: {
            VStack(spacing: 24) {
                defaultLabel
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

                Divider()

                InputField("Floating Label", text: $floatingText)
                    .inputFieldStyle(.floating.background(textfieldBackground))
                    .applyRules(
                        to: $floatingText,
                        rules: .maxCharacters(
                            maxCharacters,
                            enforcement: ruleEnforcement
                        ),
                        isEnabled: maxCharacterRuleEnabled
                    )

                Divider()

                InputField(
                    "Formatted Input field",
                    value: $amount,
                    format: .currency(code: "SEK")
                )
                .inputFieldStyle(.default.background(textfieldBackground))
                .supportiveText(supportTextEnabled ? "Fill in amount" : nil)
                .keyboardType(.numberPad)
            }
            .optionalField(isOptional)
            .expandTextArea(expandTextArea ? 4... : 1...)
            .padding(16)
            .background(
                textfieldBackground == .white ? Color.l1Neutral02 : .l1Neutral01
            )
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

            DemoSection("Textfield background color") {
                Picker(
                    "Background",
                    selection: $textfieldBackground.animation()
                ) {
                    Text("White")
                        .tag(InputFieldStyle.Configuration.Background.white)
                    Text("Gray")
                        .tag(InputFieldStyle.Configuration.Background.gray)
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
