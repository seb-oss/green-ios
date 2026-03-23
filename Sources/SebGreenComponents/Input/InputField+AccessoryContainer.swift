import SwiftUI

extension InputField {
    struct AccessoryContainer: View {
        @Environment(\.textInputCharacterLimit) private var characterLimit
        /// Only for snapshot tests
        @Environment(\.overrideFocusVisibility) private var overrideFocusVisibility

        @Binding var value: F.FormatInput?
        private let isEditing: Bool

        init(_ value: Binding<F.FormatInput?>, isEditing: Bool) {
            self._value = value
            self.isEditing = isEditing
        }
        
        private var presentClearButton: Bool {
            if overrideFocusVisibility {
                true
            } else if let stringValue = value as? String {
                !stringValue.isEmpty && isEditing
            } else {
                value != nil && isEditing
            }
        }
        
        private var presentCharacterLimit: Bool {
            overrideFocusVisibility || isEditing
        }

        var body: some View {
            VStack(alignment: .trailing, spacing: .zero) {
                if let characterLimit, let stringValue = value as? String {
                    CharacterLimitView(
                        characterCount: stringValue.count,
                        maxLimit: characterLimit
                    )
                    .opacity(presentCharacterLimit ? 1 : 0)
                }

                clearButton
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .animation(.default, value: isEditing)
            .accessibilityHidden(true)
        }

        private var clearButton: some View {
            Button(systemName: "xmark.circle.fill", action: clearField)
                .foregroundStyle(Color.contentNeutral02)
                .opacity(presentClearButton ? 1 : 0)
                .animation(.snappy, value: value)
        }
        
        private func clearField() {
            withAnimation {
                value = nil
            }
        }
    }
}
