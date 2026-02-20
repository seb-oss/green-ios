import SwiftUI

struct InfoButton: View {
    let action: () -> Void
    var body: some View {
        Button("", systemImage: "info.circle", action: action)
            .foregroundStyle(Color.contentNeutral01)
    }
}

enum InputFieldStyle {
    case `default`
    case floating
}

struct InputField<Accessory: View>: View {
    @Environment(\.inputFieldStyle) private var inputStyle
    @Environment(\.optionalField) private var optionalField
    @Environment(\.validationError) private var validationError

    @State private var text: String = ""  // TODO: Setup a binding text to the parent or just change this to binding depending on requirement
    private let label: any StringProtocol
    private let accessory: Accessory

    private var title: any StringProtocol {
        guard optionalField else { return label }
        let optional = String(localized: "optional")
        return "\(label) (\(optional))"
    }

    private var hasValidationError: Bool {
        validationError != nil
    }

    init(
        _ label: any StringProtocol,
        @AccessoryBuilder accessory: () -> Accessory = AccessoryBuilder
            .buildBlock
    ) {
        self.label = label
        self.accessory = accessory()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            inputField

            if let validationError {
                validationView(validationError)
            }
        }
        .animation(.default, value: hasValidationError)
    }
    
    @ViewBuilder
    private var inputField: some View {
        switch inputStyle {
        case .default:
            DefaultLabel(
                title,
                text: $text,
                textField: textField,
                accessory: accessory
            )
        case .floating:
            FloatingLabel(
                title,
                text: $text,
                textField: textField,
                accessory: accessory
            )
        }
    }

    private var textField: some View {
        Group {
            if #available(iOS 16.0, *) {
                TextField("", text: $text, axis: .vertical)
            } else {
                TextField("", text: $text)
            }
        }
        .foregroundStyle(Color.contentNeutral01)
    }
    
    private func validationView(_ error: Error) -> some View {
        HStack {
            Image(systemName: "exclamationmark.square.fill")
                .accessibilityHidden(true)
            Text(error.localizedDescription)
                .typography(.bodyBookS)
                .fixedSize(horizontal: false, vertical: true)

        }
        .foregroundColor(Color.contentNegative01)
        .padding(.horizontal, 14) // Needs to be 14px due to 2px border.
    }
}


@available(iOS 17, *)
#Preview {
    @Previewable @State var hasError = false

    ScrollView {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.l1Neutral02)

            VStack(spacing: 24) {
                Toggle("Toggle error", isOn: $hasError)

                Divider()

                InputField("Custom header") {
                    InfoButton {

                    }
                }
                .inputFieldStyle(.default)
                .supportiveText("Hello")
                .optionalField()
                .validation(
                    hasError ? NSError(domain: "", code: 999) : nil
                )

                Divider()

                InputField("Floating header 2")
                    .inputFieldStyle(.floating)
                    .clearable()
                    .validation(
                        hasError ? NSError(domain: "", code: 999) : nil
                    )
            }
            .padding()
        }
        .animation(.default, value: hasError)
    }
}
