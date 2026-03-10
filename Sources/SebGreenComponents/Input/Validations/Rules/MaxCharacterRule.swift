import Foundation

@available(iOS 16, *)
public struct MaxCharacterRule: ValidationRule {
    let maxCharacters: Int
    private let enforcement: Enforcement
    
    public init(maxCharacters: Int, enforcement: Enforcement) {
        self.maxCharacters = maxCharacters
        self.enforcement = enforcement
    }

    /// Defines how the character limit is enforced.
    public enum Enforcement {
        /// Warns the user when exceeding the limit but allows input to continue.
        case soft
        /// Prevents input from exceeding the limit by truncating excess characters.
        case hard
    }

    public func transform(_ value: String) -> ValidationTransformResult<String>? {
        guard case .hard = enforcement,
              hasExceededMaxCharacters(value) else {
            return nil
        }

        return .init(
            value: String(value.prefix(maxCharacters)),
            feedback: .impact
        )
    }

    public func validate(_ value: String) throws(ValidationError) {
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
public extension ValidationRule where Self == MaxCharacterRule {
    static func maxCharacters(
        _ count: Int,
        enforcement: MaxCharacterRule.Enforcement = .soft
    ) -> Self {
        MaxCharacterRule(maxCharacters: count, enforcement: enforcement)
    }
}
