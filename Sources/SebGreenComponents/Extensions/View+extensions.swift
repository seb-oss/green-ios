import SwiftUI

extension EnvironmentValues {
    @Entry var inputFieldStyle: InputFieldStyle = .default
    @Entry var textInputCharacterLimit: Int?
    @Entry var optionalField = false
    @Entry var clearButtonEnabled = false
    @Entry var supportiveText: String?
    @Entry var validationError: Error?
}

extension View {
    public func inputFieldStyle(_ style: InputFieldStyle) -> some View {
        environment(\.inputFieldStyle, style)
    }

    func textInputCharacterLimit(_ limit: Int) -> some View {
        environment(\.textInputCharacterLimit, limit)
    }

    public func optionalField(_ isOptional: Bool = true) -> some View {
        environment(\.optionalField, isOptional)
    }

    public func clearable(_ isClearable: Bool = true) -> some View {
        environment(\.clearButtonEnabled, isClearable)
    }

    public func supportiveText(_ text: String?) -> some View {
        environment(\.supportiveText, text)
    }

    public func validation(_ error: Error?) -> some View {
        environment(\.validationError, error)
    }
}
