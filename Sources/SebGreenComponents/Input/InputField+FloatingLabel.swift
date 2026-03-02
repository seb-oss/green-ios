import SwiftUI

extension InputField {
    struct FloatingLabel<TextField: View>: View {
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        @Environment(\.expandTextAreaRange) private var expandTextAreaRange
        @Environment(\.validationError) private var validationError

        @Binding var value: F.FormatInput?
        @FocusState private var isFocused: Bool

        @State private var isEditing = false

        private let label: any StringProtocol
        private let textField: TextField
        private let infoContainer: InfoContainer

        private var minimumFrameHeight: CGFloat {
            verticalSizeClass == .compact ? 64 : 72
        }

        private var presentTextField: Bool {
            let isSingleLine = expandTextAreaRange.lowerBound == 1
            let hasValue = if let stringValue = value as? String {
                !stringValue.isEmpty
            } else {
                value != nil
            }
            return !isSingleLine || isEditing || hasValue
        }

        private var hasValidationError: Bool {
            validationError != nil
        }

        private var hasInfoContainer: Bool {
            InfoContainer.self != EmptyView.self
        }

        init(
            _ label: any StringProtocol,
            value: Binding<F.FormatInput?>,
            infoContainer: InfoContainer,
            @ViewBuilder textField: () -> TextField,
        ) {
            self._value = value
            self.label = label
            self.textField = textField()
            self.infoContainer = infoContainer
        }

        var body: some View {
            HStack(alignment: .center, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    floatingLabel

                    if presentTextField {
                        textField
                            .focused($isFocused)
                            .onChange(of: isFocused) { newValue in
                                isEditing = newValue
                            }
                    }
                }

                Spacer(minLength: .spaceM)

                AccessoryContainer($value, isEditing: isEditing)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.spaceM)
            .frame(
                maxWidth: .infinity,
                minHeight: minimumFrameHeight,
                alignment: .leading
            )
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.l2Neutral02)
                    .animation(.snappy, value: value)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(style: .init(lineWidth: hasValidationError ? 2 : 1))
                    .foregroundStyle(
                        hasValidationError
                            ? Color.borderNegative01 : Color.clear
                    )
                    .animation(.snappy, value: value)
            }
            .contentShape(.rect(cornerRadius: 16))
            .onTapGesture {
                isEditing = true
                isFocused = true
            }
        }

        private var floatingLabel: some View {
            Text(label)
                .typography(
                    presentTextField ? .detailBookXs : .detailBookM
                )
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(Color.contentNeutral02)
                .animation(.snappy, value: presentTextField)
        }
    }
}
