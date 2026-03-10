import SwiftUI

@available(iOS 16.0, *)
private struct ValidationRuleModifier<Value: Equatable>: ViewModifier {
    private let rules: [any ValidationRule<Value>]
    private let isEnabled: Bool
    @Binding var value: Value

    @State private var validationError: ValidationError?
    @State private var toggle = false

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
        content
            .onChange(of: value, perform: validateValue)
            .environment(\.validationError, validationError)
            .sensoryFeedbackIfAvailable(trigger: toggle) {
                validationError?.sensoryFeedback
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
            guard let transformed = rule.transform(newValue) else {
                continue
            }
            value = transformed
            return
        }

        validationError = nil
        for rule in rules {
            do {
                try rule.validate(newValue)
            } catch {
                validationError = error
                if error.sensoryFeedback != nil {
                    toggle.toggle()
                }
                return
            }
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
            .environment(\.textInputCharacterLimit, isEnabled ? maxCharacters : nil)
    }
}
