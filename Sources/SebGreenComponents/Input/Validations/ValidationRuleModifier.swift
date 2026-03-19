import SwiftUI

@available(iOS 16.0, *)
private struct ValidationRuleModifier<Value: Equatable>: ViewModifier {
    private let rules: [any ValidationRule<Value>]
    private let isEnabled: Bool
    @Binding var value: Value

    @State private var validationError: Error?
    @State private var sensoryFeedback: HapticFeedback?
    @State private var toggle = false

    @available( iOS, deprecated: 17, message: "Just use .onChange(of: initial:) instead of this hacky workaround")
    @State private var initialValueSet = false

    init(
        rules: [any ValidationRule<Value>],
        value: Binding<Value>,
        isEnabled: Bool
    ) {
        self.rules = rules
        self.isEnabled = isEnabled
        self._value = value
    }

    func body(content: Content) -> some View {
        Group {
            if #available(iOS 17, *) {
                content
                    .onChange(of: value, initial: true) {
                        validateValue(value)
                    }
            } else {
                content
                    .onChange(of: value, perform: validateValue)
                    .onAppear {
                        guard !initialValueSet else { return }
                        initialValueSet = true
                        validateValue(value)
                    }
            }
        }
        .environment(\.validationError, validationError)
        .sensoryFeedbackIfAvailable(trigger: toggle) {
            sensoryFeedback
        }
    }

    private func validateValue(_ newValue: Value) {
        guard isEnabled else {
            validationError = nil
            return
        }
        guard !rules.isEmpty else { return }

        // Return immediately on first transformation
        for rule in rules {
            guard let result = rule.transform(newValue) else {
                continue
            }
            value = result.value
            trigger(result.feedback)
            return
        }

        validationError = nil
        for rule in rules {
            do {
                try rule.validate(newValue)
            } catch {
                validationError = error
                trigger(error.sensoryFeedback)
                return
            }
        }
    }

    private func trigger(_ feedback: HapticFeedback?) {
        sensoryFeedback = feedback
        if feedback != nil {
            toggle.toggle()
        }
    }
}

extension View {
    @available(iOS 16, *)
    @ViewBuilder
    public func applyRules<V: Equatable>(
        to value: Binding<V>,
        rules: any ValidationRule<V>...,
        isEnabled: Bool = true
    ) -> some View {
        let maxCharacters =
            rules
            .compactMap { $0 as? MaxCharacterRule }
            .first?.maxCharacters

        self
            .modifier(
                ValidationRuleModifier(
                    rules: rules,
                    value: value,
                    isEnabled: isEnabled
                )
            )
            .environment(
                \.textInputCharacterLimit,
                isEnabled ? maxCharacters : nil
            )
    }
}
