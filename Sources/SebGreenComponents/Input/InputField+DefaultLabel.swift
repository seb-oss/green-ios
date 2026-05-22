import SwiftUI

extension InputField {
    struct DefaultLabel<TextField: View>: View {
        @Environment(\.verticalSizeClass) private var verticalSizeClass
        @Environment(\.inputFieldStyle) private var inputFieldStyle
        @Environment(\.supportiveText) private var supportiveText
        @Environment(\.validationError) private var validationError
        /// Only for snapshot tests
        @Environment(\.overrideFocusVisibility) private var overrideFocusVisibility

        @FocusState private var isFocused: Bool
        @Binding var value: F.FormatInput?
        @State private var isEditing = false

        private let label: any StringProtocol
        private let infoContainer: InfoContainer
        private let textField: TextField

        private let cornerRadius: CGFloat = 16

        init(
            _ label: any StringProtocol,
            value: Binding<F.FormatInput?>,
            infoContainer: InfoContainer,
            @ViewBuilder textField: () -> TextField
        ) {
            self._value = value
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
            overrideFocusVisibility || isEditing || hasValidationError ? 2 : 1
        }

        var body: some View {
            VStack(alignment: .leading, spacing: .gds(.spaceXs)) {
                header

                HStack(alignment: .center, spacing: .gds(.spaceM)) {
                    textField
                        .focused($isFocused)

                    AccessoryContainer($value, isEditing: isEditing)
                }
                .padding(.gds(.spaceM))
                .background {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.surfaceAware)
                        .animation(.snappy, value: value)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(style: .init(lineWidth: borderWidth))
                        .foregroundStyle(
                            hasValidationError
                                ? Color.borderNegative01
                                : Color.gds(.borderNeutral01)
                        )
                        .animation(.snappy, value: value)
                }
                .contentShape(.rect(cornerRadius: cornerRadius))
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
            VStack(alignment: .leading, spacing: .gds(.space5xs)) {
                HStack {
                    Text(label)
                        .accessibilityHidden(true)
                    Spacer(minLength: .zero)
                    infoContainer
                }
                .font(.gds(.detailMBook))
                .foregroundStyle(Color.contentNeutral01)

                if let supportiveText, !supportiveText.isEmpty {
                    Text(supportiveText)
                        .font(.gds(.detailSBook))
                        .foregroundStyle(Color.contentNeutral02)
                        .accessibilityHidden(true)
                }
            }
            .padding(.horizontal, .gds(.spaceM))
        }
    }
}
