import SwiftUI

enum InputFieldStyle {
    case `default`
    case floating
}

extension EnvironmentValues {
    @Entry var inputFieldStyle: InputFieldStyle = .default
}

extension View {
    func inputFieldStyle(_ style: InputFieldStyle) -> some View {
        self.environment(\.inputFieldStyle, style)
    }
}

struct InputField<Label: View>: View {
    @Environment(\.inputFieldStyle) private var inputStyle

    @State private var text: String = ""  // TODO: Setup a binding text to the parent or just change this to binding depending on requirement
    private let label: Label

    init(
        @ViewBuilder label: () -> Label,
    ) {
        self.label = label()
    }

    var body: some View {
        switch inputStyle {
        case .default:
            DefaultInputField($text) {
                label
            } textField: {
                textField
            }
        case .floating:
            FloatingInputField($text) {
                label
            } textField: {
                textField
            }
        }
    }

    private var textField: some View {
        TextField("", text: $text)
            .foregroundStyle(Color.contentNeutral01)
    }
}

extension InputField where Label == Text {
    init(
        _ title: any StringProtocol,
    ) {
        self.label = Text(title)
    }
}

private struct DefaultInputField<Label: View, TextField: View>: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String

    let label: Label
    let textField: TextField

    init(
        _ text: Binding<String>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder textField: () -> TextField,
    ) {
        self._text = text
        self.label = label()
        self.textField = textField()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            label
                .padding(.horizontal, 16)
            textField
                .focused($isFocused)
                .padding(.horizontal, 16)
                .frame(minHeight: 64)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.l2Neutral02)
                }
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(style: .init(lineWidth: 1))
                }
                .contentShape(.rect(cornerRadius: 16))
                .onTapGesture {
                    isFocused = true
                }
        }
    }
}

private struct FloatingInputField<Label: View, TextField: View>: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var minimumFrameHeight: CGFloat {
        horizontalSizeClass == .compact ? 64 : 72
    }

    @FocusState private var isFocused: Bool
    @Binding var text: String

    let label: Label
    let textField: TextField

    @State private var isEditing = false

    private var presentTextField: Bool {
        isEditing || !text.isEmpty
    }

    init(
        _ text: Binding<String>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder textField: () -> TextField,
    ) {
        self._text = text
        self.label = label()
        self.textField = textField()
    }

    var body: some View {
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
        .padding(.horizontal, .spaceM)
        .frame(
            maxWidth: .infinity,
            minHeight: minimumFrameHeight,
            alignment: .leading
        )
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.l2Neutral02)
        }
        .contentShape(.rect(cornerRadius: 16))
        .onTapGesture {
            isEditing = true
            isFocused = true
        }
    }

    private var floatingLabel: some View {
        label
            .typography(
                presentTextField ? .bodyBookS : .bodyBookL
            )
            .foregroundColor(.contentNeutral02)
            .animation(.snappy, value: presentTextField)
    }
}

#Preview {
    VStack(spacing: 24) {
        InputField("Custom header")
            .inputFieldStyle(.default)

        Divider()

        InputField {
            HStack {
                Text("Sicky header")
                Spacer()
                Button("", systemImage: "info") {}
            }
        }

        Divider()

        InputField("Floating header 2")
            .inputFieldStyle(.floating)
    }
    .padding()
    .background {
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(Color.l1Neutral02)
    }
    .padding(.horizontal)
}
