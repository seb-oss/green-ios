import SwiftUI

extension EnvironmentValues {
    @Entry var inputFieldStyle: InputFieldStyle = .default
    @Entry var textInputCharacterLimit: Int?
    @Entry var optionalField = false
    @Entry var clearButtonEnabled = false
    @Entry var supportiveText: String?
    @Entry var validationError: Error?
    @Entry var expandTextAreaRange: PartialRangeFrom<Int> = 1...
}

extension View {
    func inputFieldStyle(_ style: InputFieldStyle) -> some View {
        environment(\.inputFieldStyle, style)
    }

    func textInputCharacterLimit(_ limit: Int) -> some View {
        environment(\.textInputCharacterLimit, limit)
    }

    func optionalField(_ isOptional: Bool = true) -> some View {
        environment(\.optionalField, isOptional)
    }

    func clearable(_ isClearable: Bool = true) -> some View {
        environment(\.clearButtonEnabled, isClearable)
    }

    func supportiveText(_ text: String?) -> some View {
        environment(\.supportiveText, text)
    }

    func validation(_ error: Error?) -> some View {
        environment(\.validationError, error)
    }
    
    func expandTextArea(_ range: PartialRangeFrom<Int> = 4...) -> some View {
        environment(\.expandTextAreaRange, range)
    }
}
