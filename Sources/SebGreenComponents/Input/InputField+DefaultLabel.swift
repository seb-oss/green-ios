import SwiftUI

extension InputField {
    struct DefaultLabel<TextField: View>: View {
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        @Environment(\.supportiveText) private var supportiveText
        @Environment(\.validationError) private var validationError

        @FocusState private var isFocused: Bool
        @Binding var text: String

        private let label: any StringProtocol
        private let infoContainer: InfoContainer
        private let textField: TextField

        init(
            _ label: any StringProtocol,
            text: Binding<String>,
            infoContainer: InfoContainer,
            @ViewBuilder textField: () -> TextField
        ) {
            self._text = text
            self.label = label
            self.infoContainer = infoContainer
            self.textField = textField()
        }

        private var hasValidationError: Bool {
            validationError != nil
        }

        private var hasInfoContainer: Bool {
            InfoContainer.self != EmptyView.self
        }

        private var borderWidth: CGFloat {
            isEditing || hasValidationError ? 2 : 1
        }

        @State private var isEditing = false

        var body: some View {
            VStack(alignment: .leading, spacing: .spaceXs) {
                header

                HStack(alignment: .center, spacing: .spaceM) {
                    textField
                        .focused($isFocused)

                    AccessoryContainer($text, isEditing: isEditing)
                }
                .padding(.spaceM)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.l2Neutral02)
                        .animation(.snappy, value: text)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(style: .init(lineWidth: borderWidth))
                        .foregroundStyle(
                            hasValidationError
                                ? Color.borderNegative01
                                : Color.borderInteractive
                        )
                        .animation(.snappy, value: text)
                }
                .contentShape(.rect(cornerRadius: 16))
                .frame(minHeight: 64)
                .fixedSize(horizontal: false, vertical: true)
                .animation(.default, value: isFocused)
                .animation(.default, value: isEditing)
                .animation(.default, value: hasValidationError)
                .onTapGesture {
                    isFocused = true
                }
                .onChange(of: isFocused) {
                    isEditing = $0
                }
            }
        }

        private var header: some View {
            VStack(alignment: .leading, spacing: .space5xs) {
                HStack {
                    Text(label)
                        .typography(.detailBookM)
                        .foregroundStyle(Color.contentNeutral01)

                    Spacer(minLength: .zero)

                    infoContainer
                        .typography(.detailBookM)
                }

                if let supportiveText, !supportiveText.isEmpty {
                    Text(supportiveText)
                        .typography(.detailBookS)
                        .foregroundStyle(Color.contentNeutral02)
                }
            }
            .padding(.horizontal, .spaceM)
        }
    }
}

#Preview {
    InputField("Floating", text: .constant(""))
        .inputFieldStyle(.default)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.l1Neutral02)
        }
        .padding(.horizontal)
}
