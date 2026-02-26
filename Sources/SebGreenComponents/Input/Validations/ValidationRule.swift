/// A rule that validates and optionally transforms input values.
///
/// Validation rules are applied in two phases:
/// 1. **Transform phase**: `transform(_:)` is called first. If it returns a non-nil value, the input is replaced and validation stops for this cycle.
/// 2. **Validate phase**: `validate(_:)` is called to check the value and throw errors if invalid.
protocol ValidationRule<Value> {
    associatedtype Value: Equatable

    /// Transforms the value before validation occurs.
    ///
    /// Called before `validate(_:)`. Return a transformed value to modify the input,
    /// or `nil` if no transformation is needed.
    /// - Parameter value: The current input value.
    /// - Returns: A transformed value, or `nil` to leave unchanged.
    func transform(_ value: Value) -> Value?

    /// Validates the value and throws an error if invalid.
    ///
    /// Called after `transform(_:)` completes without modifying the value.
    /// - Parameter value: The value to validate.
    /// - Throws: A `ValidationError` if validation fails. The error may include
    ///   sensory feedback (iOS 17+) to provide haptic response on failure.
    func validate(_ value: Value) throws(ValidationError)
}

extension ValidationRule {
    func transform(_ value: Value) -> Value? { nil }
}
