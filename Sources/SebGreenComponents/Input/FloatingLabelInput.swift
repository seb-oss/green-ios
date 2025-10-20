import SwiftUI

/// A text input with a floating placeholder that animates into a label inside the box when editing or when text is present.
public struct FloatingLabelInput: View {
    @Binding public var text: String
    let placeholder: String
    
    @State private var isEditing: Bool = false
    @FocusState private var isFocused: Bool

    @Binding var isValid: Bool

    let characterLimit: Int?
    let supportingText: String?
    let errorText: String?
    let isMultiline: Bool
    let notificationCenter: NotificationCenter
    /// - Parameters:
    ///   - text: Binding to the text content.
    ///   - placeholder: The placeholder string shown when empty and not focused.
    ///   - characterLimit: Limit for characters that the input field enforces.
    public init(
        text: Binding<String>,
        placeholder: String,
        characterLimit: Int? = nil,
        supportingText: String? = nil,
        errorText: String? = nil,
        isValid: Binding<Bool>,
        isMultiline: Bool = false,
        notificationCenter: NotificationCenter = .default
    ) {
        self._text = text
        self.placeholder = placeholder
        self.characterLimit = characterLimit
        self.supportingText = supportingText
        self.errorText = errorText
        self._isValid = isValid
        self.isMultiline = isMultiline
        self.notificationCenter = notificationCenter
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            inputField
            
            hintAccessoryView
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.4)) {
                isEditing = true
                isFocused = true
            }
        }
        .onChange(of: isFocused) { focused in
            if !focused && text.isEmpty { isEditing = false }
        }
    }
}

// MARK: - Input field
private extension FloatingLabelInput {
    var inputField: some View {
        ZStack(alignment: .leading) {
            background

            HStack(spacing: .zero) {
                labeledInput
                Spacer(minLength: 0)
                accessoryStack
            }
            .padding(.horizontal, .spaceM)
            .padding(.vertical, .spaceS)
        }
    }

    var hasContent: Bool {
        text != ""
    }
}

// MARK: - Background

private extension FloatingLabelInput {
    var background: some View {
        Color.groupedBackgroundSecondary
            .cornerRadius(.spaceS)
    }
}

// MARK: Labeled input

private extension FloatingLabelInput {
    @ViewBuilder
    var labeledInput: some View {
        if isEditing || hasContent {
            labeledTextFieldStack
        } else {
            placeholderView
        }
    }
}

// MARK: - Placeholder state

private extension FloatingLabelInput {
    var placeholderView: some View {
        Text(placeholder)
            .typography(.headlineEmphasized)
            .padding(.vertical, .spaceS)
            .foregroundStyle(isValid ? Color.contentNeutral02 : Color.contentNegative01)
    }
}

// MARK: - Editing state

private extension FloatingLabelInput {

    // MARK: Labeled text field

    var labeledTextFieldStack: some View {
        VStack(alignment: .leading, spacing: .zero) {
            label

            if isMultiline {
                textEditor
            } else {
                textfield
            }
        }
    }

    var label: some View {
        Text(placeholder)
            .foregroundStyle(labelColor)
            .typography(.subhead)
    }

    var labelColor: Color {
        isValid || isFocused ? Color.contentNeutral02 : Color.contentNegative01
    }

    var textfield: some View {
        TextField("", text: $text)
            .focused($isFocused)
            .typography(.headlineEmphasized)
            .foregroundStyle(textFieldForegroundColor)
            .onReceive(textDidChange) { notification in
                textChangeNotifationReceived(notification)
            }
            .onAppear {
                DispatchQueue.main.async {
                    isFocused = !hasContent
                }
            }
    }

    var textEditor: some View {
        TextEditor(text: $text)
            .background(Color.clear)
            .focused($isFocused)
            .typography(.headlineEmphasized)
            .foregroundStyle(textFieldForegroundColor)
            .onReceive(textDidChange) { notification in
                textChangeNotifationReceived(notification)
            }
            .onAppear {
                DispatchQueue.main.async {
                    isFocused = !hasContent
                }
            }
    }

    var textFieldForegroundColor: Color {
        isValid || isFocused ? Color.contentNeutral01 : Color.contentNegative01
    }

    var textDidChange: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
    }

    // MARK: Accessory elements

    var accessoryStack: some View {
        VStack(alignment: .trailing, spacing: .zero) {
            if isFocused {
                if characterLimit != nil {
                    characterCountLabel
                }

                clearButton
            } else if !isValid {
                errorIcon
            }
        }
    }

    var clearButton: some View {
        Button(action: clearInput) {
            Image(systemName: "xmark.circle.fill")
                .typography(.headline)
                .foregroundStyle(Color.contentNeutral02)
        }
    }

    func clearInput() {
        text = ""
    }

    var characterCountLabel: some View {
        Text(characterCountString)
            .foregroundStyle(Color.contentNeutral01)
            .typography(.caption1)
    }

    var characterCountString: String {
        guard let characterLimit else {
            return ""
        }

        return "\(text.count)/\(characterLimit)"
    }

    var errorIcon: some View {
        Image(systemName: "exclamationmark.square.fill")
            .foregroundStyle(Color.contentNegative01)
    }

    private func textChangeNotifationReceived(_ notification: Notification) {
        guard isFocused, let textField = notification.object as? UITextField, textField.isFirstResponder else { return }
        textField.text = text
    }
}

// MARK: - Hint accessory
private extension FloatingLabelInput {
    private var hintAccessoryView: some View {
        Text(hintText)
            .foregroundStyle(isValid ? Color.contentNeutral02 : Color.contentNegative01)
            .typography(.footnote)
            .padding(.top, .spaceXs)
            .padding(.leading, .spaceM)
    }

    private var hintText: String {
        if isValid {
            return supportingText ?? ""
        } else {
            return errorText ?? ""
        }
    }
}

struct DummyForm: View {
    @State private var textDefault = ""
    @State private var textSupport = ""
    @State private var textCounter = ""
    @State private var textPrefilled = "Content shared"
    @State private var textNearLimit = "1234567890" // 9/10

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .spaceM) {
                FloatingLabelInput(
                    text: $textDefault,
                    placeholder: "Longer Label for accessbility",
                    isValid: .constant(true),
                    isMultiline: true
                )

                FloatingLabelInput(
                    text: $textSupport,
                    placeholder: "Label",
                    supportingText: "Support text for input",
                    isValid: .constant(true),
                )

                FloatingLabelInput(
                    text: $textCounter,
                    placeholder: "Label",
                    characterLimit: 10,
                    isValid: .constant(true)
                )

                FloatingLabelInput(
                    text: $textPrefilled,
                    placeholder: "Label",
                    characterLimit: 50,
                    isValid: .constant(true)
                )
                

                FloatingLabelInput(
                    text: $textNearLimit,
                    placeholder: "Label",
                    characterLimit: 10,
                    supportingText: "Keep it short",
                    errorText: "Character limit reached",
                    isValid: .constant(true)
                )
                
                Text(verbatim: "Tip: Tap any field to edit and see the floating label + clear button.")
                    .typography(.caption1)
                    .foregroundStyle(Color.contentNeutral02)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        }
        .background(Color.groupedBackgroundPrimary)
    }
}

struct FloatingLabelInput_Previews: PreviewProvider {
    static var previews: some View {
        DummyForm()
            .background(Color.groupedBackgroundPrimary)
    }
}
