import SwiftUI

extension InputField {
    struct DefaultLabel<TextField: View>: View {
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        @Environment(\.supportiveText) private var supportiveText
        @Environment(\.validationError) private var validationError

        @FocusState private var isFocused: Bool
        @Binding var text: String

        private let label: any StringProtocol
        private let textField: TextField
        private let accessory: Accessory

        init(
            _ label: any StringProtocol,
            text: Binding<String>,
            textField: TextField,
            accessory: Accessory
        ) {
            self._text = text
            self.label = label
            self.textField = textField
            self.accessory = accessory
        }

        private var minimumFrameHeight: CGFloat {
            verticalSizeClass == .compact ? 54 : 64
        }

        private var hasValidationError: Bool {
            validationError != nil
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                header
                textField
                    .focused($isFocused)
                    .padding(16)
                    .frame(minHeight: minimumFrameHeight)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.l2Neutral02)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                style: .init(
                                    lineWidth: hasValidationError ? 2 : 1
                                )
                            )
                            .foregroundStyle(
                                hasValidationError
                                    ? Color.borderNegative01
                                    : Color.borderInteractive
                            )
                    }
                    .contentShape(.rect(cornerRadius: 16))
                    .onTapGesture {
                        isFocused = true
                    }
                    .animation(.default, value: hasValidationError)
            }
        }

        private var header: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(label)
                        .typography(.bodyBookM)
                        .foregroundStyle(Color.contentNeutral01)

                    Spacer()

                    accessory
                }
                if let supportiveText, !supportiveText.isEmpty {
                    Text(supportiveText)
                        .typography(.bodyBookS)
                        .foregroundStyle(Color.contentNeutral02)
                        .padding(.trailing, 16)
                }
            }
            .padding(.leading, 16)
        }
    }
}

#Preview {
    InputField("Floating")
        .inputFieldStyle(.default)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.l1Neutral02)
        }
        .padding(.horizontal)
}
