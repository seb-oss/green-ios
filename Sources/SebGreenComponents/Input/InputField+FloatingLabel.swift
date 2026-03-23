import SwiftUI

extension InputField {
    struct FloatingLabel<TextField: View>: View {
        @Environment(\.accessibilityVoiceOverEnabled) private
            var isVoiceOverEnabled
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        @Environment(\.inputFieldStyle) private var inputFieldStyle
        @Environment(\.expandTextAreaRange) private var expandTextAreaRange
        @Environment(\.validationError) private var validationError

        @Binding var value: F.FormatInput?
        @FocusState private var isFocused: Bool

        @State private var isEditing = false

        private let label: any StringProtocol
        private let textField: TextField
        private let cornerRadius: CGFloat = 16

        private var minimumFrameHeight: CGFloat {
            verticalSizeClass == .compact ? 64 : 72
        }

        private var isExpanded: Bool {
            isSingleLine ? isFocused || hasValue || isVoiceOverEnabled : true
        }

        private var isSingleLine: Bool {
            expandTextAreaRange.lowerBound == 1
        }

        private var hasValue: Bool {
            if let stringValue = value as? String {
                return !stringValue.isEmpty
            }
            return value != nil
        }

        private var hasValidationError: Bool {
            validationError != nil
        }

        init(
            _ label: any StringProtocol,
            value: Binding<F.FormatInput?>,
            @ViewBuilder textField: () -> TextField,
        ) {
            self._value = value
            self.label = label
            self.textField = textField()
        }

        var body: some View {
            HStack(alignment: .center, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    floatingLabel

                    textField
                        .focused($isFocused)
                        .opacity(isExpanded ? 1 : 0)
                        .frame(height: isExpanded ? nil : 0)
                }

                Spacer(minLength: .spaceM)

                AccessoryContainer($value, isEditing: isEditing)
            }
            .padding(.spaceM)
            .frame(
                maxWidth: .infinity,
                minHeight: minimumFrameHeight,
                alignment: .leading
            )
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.surfaceAware)
                    .animation(.snappy, value: value)
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(style: .init(lineWidth: hasValidationError ? 2 : 1))
                    .foregroundStyle(
                        hasValidationError
                            ? Color.borderNegative01 : Color.clear
                    )
                    .animation(.snappy, value: value)
            }
            .contentShape(.rect(cornerRadius: cornerRadius))
            .onTapGesture {
                isFocused = true
            }
            .fixedSize(horizontal: false, vertical: true)
        }

        private var floatingLabel: some View {
            Text(label)
                .typography(
                    isExpanded ? .detailBookXs : .detailBookM
                )
                .foregroundStyle(Color.contentNeutral02)
                .animation(.snappy, value: isExpanded)
                .accessibilityHidden(true)
        }
    }
}
