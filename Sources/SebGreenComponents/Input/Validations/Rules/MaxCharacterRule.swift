import Foundation

@available(iOS 16, *)
struct MaxCharacterRule: ValidationRule {
    typealias Value = String
    
    let maxCharacters: Int
    let enforcement: Enforcement

    /// Defines how the character limit is enforced.
    enum Enforcement {
        /// Warns the user when exceeding the limit but allows input to continue.
        case soft
        /// Prevents input from exceeding the limit by truncating excess characters.
        case hard
    }

    func transform(_ value: String) -> String? {
        guard case .hard = enforcement else {
            return nil
        }

        return hasExceededMaxCharacters(value)
            ? String(value.prefix(maxCharacters)) : nil
    }

    func validate(_ value: String) throws(ValidationError) {
        if hasExceededMaxCharacters(value) {
            let localizedError = String(localized: "SebGreenComponents.InputField.Validation.MaxCharacters", bundle: .module)
            throw ValidationError(
                errorDescription: String(format: localizedError, maxCharacters)
            )
        }
    }

    private func hasExceededMaxCharacters(_ value: String) -> Bool {
        value.count > maxCharacters
    }
}

@available(iOS 16, *)
extension ValidationRule where Self == MaxCharacterRule {
    static func maxCharacters(
        _ count: Int,
        enforcement: MaxCharacterRule.Enforcement = .soft
    ) -> Self {
        MaxCharacterRule(maxCharacters: count, enforcement: enforcement)
    }
}
