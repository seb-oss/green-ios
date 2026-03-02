import SwiftUI

extension InputField {
    struct AccessoryContainer: View {
        @Environment(\.textInputCharacterLimit) private var characterLimit

        @Binding var value: F.FormatInput?
        private let isEditing: Bool

        init(_ value: Binding<F.FormatInput?>, isEditing: Bool) {
            self._value = value
            self.isEditing = isEditing
        }
        
        private var presentClearButton: Bool {
            if let stringValue = value as? String {
                !stringValue.isEmpty && isEditing
            } else {
                value != nil && isEditing
            }
        }

        var body: some View {
            VStack(alignment: .trailing, spacing: .zero) {
                if let characterLimit, let stringValue = value as? String {
                    CharacterLimitView(
                        characterCount: stringValue.count,
                        maxLimit: characterLimit
                    )
                    .opacity(isEditing ? 1 : 0)
                }

                clearButton
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .animation(.default, value: isEditing)
        }

        private var clearButton: some View {
            Button {
                withAnimation {
                    value = nil
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.contentNeutral02)
            }
            .opacity(presentClearButton ? 1 : 0)
            .animation(.snappy, value: value)
        }
    }
}
