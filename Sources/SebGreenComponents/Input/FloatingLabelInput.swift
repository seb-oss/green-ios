import SwiftUI

/// A text input with a floating placeholder that animates into a label inside the box when editing or when text is present.
public struct FloatingLabelInput: View {
    @Binding public var text: String
    let placeholder: String
    
    @State private var isEditing: Bool = false
    @FocusState private var isFocused: Bool
    
    @State var isValid: Bool
    
    let characterLimit: Int?
    let supportingText: String?
    let errorText: String?
    
    /// - Parameters:
    ///   - text: Binding to the text content.
    ///   - placeholder: The placeholder string shown when empty and not focused.
    ///   - characterLimit: Limit for characteres that the input field enforces.
    public init(
        text: Binding<String>,
        placeholder: String,
        characterLimit: Int? = nil,
        supportingText: String? = nil,
        errorText: String? = nil,
        isValid: Bool = true
    ) {
        self._text = text
        self.placeholder = placeholder
        self.characterLimit = characterLimit
        self.supportingText = supportingText
        self.errorText = errorText
        self.isValid = isValid
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
        Color.iOSBackgroundsGroupedBackgroundSecondary
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
            .padding(.vertical, true ? .spaceS :.spaceM)
            .foregroundStyle(isValid ? Color.content02 : Color.contentNegative01)
    }
}

// MARK: - Editing state

private extension FloatingLabelInput {
    
    // MARK: Labeled text field
    
    var labeledTextFieldStack: some View {
        VStack(alignment: .leading, spacing: .zero) {
            label
            
            textfield
        }
    }
    
    var label: some View {
        Text(placeholder)
            .foregroundStyle(labelColor)
            .typography(.subhead)
    }
    
    var labelColor: Color {
        isValid || isFocused ? Color.content02 : Color.contentNegative01
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
    
    var textFieldForegroundColor: Color {
        isValid || isFocused ? Color.content01 : Color.contentNegative01
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
                .foregroundStyle(Color.content02)
        }
    }
    
    func clearInput() {
        text = ""
    }
    
    var characterCountLabel: some View {
        Text(characterCountString)
            .foregroundStyle(Color.content01)
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
private extension FloatingLabelInput {
    private var hintAccessoryView: some View {
        Text(hintText)
            .foregroundStyle(isValid ? Color.content02 : Color.contentNegative01)
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
                        placeholder: "Longer Label for accessbility"
                    )


                FloatingLabelInput(
                    text: $textSupport,
                    placeholder: "Label",
                    supportingText: "Support text for input"
                )
                    
                

                FloatingLabelInput(
                    text: $textCounter,
                    placeholder: "Label",
                    characterLimit: 10,
                    isValid: false
                )

                FloatingLabelInput(
                    text: $textPrefilled,
                    placeholder: "Label",
                    characterLimit: 50
                )

                FloatingLabelInput(
                    text: $textNearLimit,
                    placeholder: "Label",
                    characterLimit: 10,
                    supportingText: "Keep it short",
                    errorText: "Character limit reached",
                    isValid: false
                )

                Text(verbatim: "Tip: Tap any field to edit and see the floating label + clear button.")
                    .typography(.caption1)
                    .foregroundStyle(Color.content02)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        }
        .background(Color.iOSGroupedBackgroundPrimary)
    }
}

struct FloatingLabelInput_Previews: PreviewProvider {
    static var previews: some View {
        DummyForm()
            .background(Color.iOSGroupedBackgroundPrimary)
    }
}

extension Color {
    static let iOSBackgroundsGroupedBackgroundSecondary: Color = Color(uiColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light
            ? UIColor(red: 1, green: 1, blue: 1, alpha: 1)   // Light mode
            : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)    // Dark mode
    })

    static let iOSGroupedBackgroundPrimary: Color = Color(uiColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light
            ? UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)   // Light mode
            : UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1)    // Dark mode
    })
    
    static let content01: Color = Color(uiColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light
            ? UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1)   // Light mode
            : UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)    // Dark mode
    })
    
    static let content02: Color = Color(uiColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light
            ? UIColor(red: 0.39, green: 0.41, blue: 0.4, alpha: 1)   // Light mode
            : UIColor(red: 0.67, green: 0.69, blue: 0.68, alpha: 1)    // Dark mode
    })
    
    static let contentNegative01: Color = Color(uiColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light
            ? UIColor(red: 0.73, green: 0.18, blue: 0.07, alpha: 1)   // Light mode
            : UIColor(red: 0.94, green: 0.54, blue: 0.46, alpha: 1)    // Dark mode
    })
}
