import SwiftUI

/// A text input with a floating placeholder that animates into a label inside the box when editing or when text is present.
public struct LabelOutsideInput: View {
    @Binding public var text: String
    let title: String
    let placeholder: String
    
    @State private var isEditing: Bool = false
    @FocusState private var isFocused: Bool
    
    @State var isValid: Bool
    
    let characterLimit: Int?
    let supportingText: String?
    let errorText: String?
    let isMultiline: Bool
    
    /// - Parameters:
    ///   - text: Binding to the text content.
    ///   - placeholder: The placeholder string shown when empty and not focused.
    ///   - characterLimit: Limit for characters that the input field enforces.
    public init(
        text: Binding<String>,
        title: String,
        placeholder: String,
        characterLimit: Int? = nil,
        supportingText: String? = nil,
        errorText: String? = nil,
        isValid: Bool = true,
        isMultiline: Bool = false
    ) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.characterLimit = characterLimit
        self.supportingText = supportingText
        self.errorText = errorText
        self.isValid = isValid
        self.isMultiline = isMultiline
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading, spacing: .space2xs) {
                label
                    .padding(.leading, .spaceM)
                
                if let hintText {
                    hintAccessoryView(with: hintText)
                }
            }
            .padding(.bottom, .spaceXs)
            
            inputField
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
private extension LabelOutsideInput {
    var inputField: some View {
        ZStack(alignment: .leading) {
            background
            
            HStack(spacing: .zero) {
                input
                    .padding(.vertical, .spaceS)
                
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

private extension LabelOutsideInput {
    var background: some View {
        Color.groupedBackgroundSecondary
            .cornerRadius(.spaceS)
    }
}

// MARK: Input

private extension LabelOutsideInput {
    @ViewBuilder
    var input: some View {
        if isEditing || hasContent {
            inputComponent
        } else {
            placeholderView
        }
    }
}

// MARK: - Placeholder state

private extension LabelOutsideInput {
    var placeholderView: some View {
        Text(placeholder)
            .typography(
                isValid ? .headline :
                .headlineEmphasized
            )
            .foregroundStyle(
                isValid ? Color.contentNeutral02 : Color.contentNegative01
            )
    }
}

// MARK: - Editing state

private extension LabelOutsideInput {
    
    // MARK: Labeled text field
    
    @ViewBuilder
    var inputComponent: some View {
        if isMultiline {
            textEditor
        } else {
            textfield
        }
    }
    
    var label: some View {
        Text(title)
            .foregroundStyle(labelColor)
            .typography(.headlineEmphasized)
    }
    
    var labelColor: Color {
        isValid || isFocused ? Color.contentNeutral01 : Color.contentNegative01
    }
    
    var textfield: some View {
        TextField("", text: limitedTextBinding)
            .focused($isFocused)
            .typography(.headlineEmphasized)
            .foregroundStyle(textFieldForegroundColor)
            .onAppear {
                DispatchQueue.main.async {
                    isFocused = !hasContent
                }
            }
    }
    
    var textEditor: some View {
        TextEditor(text: limitedTextBinding)
//            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .focused($isFocused)
            .typography(.headlineEmphasized)
            .foregroundStyle(textFieldForegroundColor)
            .onAppear {
                DispatchQueue.main.async {
                    isFocused = !hasContent
                }
            }
    }
    
    var textFieldForegroundColor: Color {
        isValid || isFocused ? Color.contentNeutral01 : Color.contentNegative01
    }
    
    var limitedTextBinding: Binding<String> {
        Binding(
            get: { text },
            set: { newValue in
                if let limit = characterLimit, newValue.count > limit {
                    text = String(newValue.prefix(limit))
                } else {
                    text = newValue
                }
            }
        )
    }
    
    // MARK: Accessory elements
    
    var accessoryStack: some View {
        VStack(alignment: .trailing ,spacing: .zero) {
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
}

// MARK: - Hint accessory
private extension LabelOutsideInput {
    private func hintAccessoryView(with hintText: String) -> some View {
        Text(hintText)
            .foregroundStyle(isValid ? Color.contentNeutral02 : Color.contentNegative01)
            .typography(.footnote)
            .padding(.top, .zero)
            .padding(.leading, .spaceM)
    }
    
    private var hintText: String? {
        if isValid {
            return supportingText
        } else {
            return errorText ?? supportingText
        }
    }
}
private extension LabelOutsideInput {
    struct DummyForm: View {
        @State private var textDefault = ""
        @State private var textSupport = ""
        @State private var textCounter = ""
        @State private var textPrefilled = "Content shared"
        @State private var textNearLimit = "1234567890" // 9/10
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: .spaceM) {
                    LabelOutsideInput(
                        text: $textDefault,
                        title: "Longer title for accessbility",
                        placeholder: "Longer Placeholder for accessbility",
                        isMultiline: false
                    )
                    
                    
                    LabelOutsideInput(
                        text: $textSupport,
                        title: "Title",
                        placeholder: "Enter something here",
                        supportingText: "Support text for input"
                    )
                    
                    
                    
                    LabelOutsideInput(
                        text: $textCounter,
                        title: "Title",
                        placeholder: "Enter address",
                        characterLimit: 10,
                        isValid: false
                    )
                    
                    LabelOutsideInput(
                        text: $textPrefilled,
                        title: "Title",
                        placeholder: "Label",
                        characterLimit: 50
                    )
                    
                    LabelOutsideInput(
                        text: $textNearLimit,
                        title: "Title",
                        placeholder: "Enter phone number",
                        characterLimit: 10,
                        supportingText: "Keep it short",
                        errorText: "Character limit reached",
                        isValid: true
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
}

struct LabelOutsideInput_Previews: PreviewProvider {
    static var previews: some View {
        LabelOutsideInput.DummyForm()
            .background(Color.groupedBackgroundPrimary)
    }
}
