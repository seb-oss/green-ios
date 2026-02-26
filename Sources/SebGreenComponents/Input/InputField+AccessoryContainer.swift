import SwiftUI

struct AccessoryContainer: View {
    @Environment(\.textInputCharacterLimit) private var characterLimit

    @Binding var text: String
    private let isEditing: Bool

    init(_ text: Binding<String>, isEditing: Bool) {
        self._text = text
        self.isEditing = isEditing
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: .zero) {
            if let characterLimit {
                CharacterLimitView(
                    characterCount: text.count,
                    maxLimit: characterLimit
                )
                .opacity(isEditing ? 1 : 0)
            }

            // TODO: Hide this view from accessibility and present it as a custom action
            clearButton
                .frame(maxHeight: .infinity, alignment: .center)
        }
        .animation(.default, value: isEditing)
    }

    private var clearButton: some View {
        Button {
            withAnimation {
                text = String()
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Color.contentNeutral02)
        }
        .opacity(
            text.count >= 1 && isEditing ? 1 : 0
        )
        .animation(.snappy, value: text)
    }
}
