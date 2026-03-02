import SwiftUI

public enum InputFieldStyle {
    case `default`
    case floating
}

public struct InputField<F: ParseableFormatStyle, InfoContainer: View>: View
where F.FormatOutput == String, F.FormatInput: Equatable {
    @Environment(\.inputFieldStyle) private var inputStyle
    @Environment(\.optionalField) private var optionalField
    @Environment(\.validationError) private var validationError
    @Environment(\.expandTextAreaRange) private var expandTextAreaRange

    @Binding private var value: F.FormatInput?
    private let format: F
    private let label: any StringProtocol
    private let infoContainer: InfoContainer

    private var title: any StringProtocol {
        guard optionalField else { return label }
        let optional = String(localized: "optional")
        return "\(label) (\(optional))"
    }

    private var hasValidationError: Bool {
        validationError != nil
    }

    private var textBinding: Binding<String> {
        Binding<String>(
            get: {
                if let stringValue = value as? String {
                    return stringValue
                } else if let value {
                    return format.format(value)
                }
                return ""
            },
            set: {
                value = try? format.parseStrategy.parse($0)
            }
        )
    }

    public init(
        _ label: any StringProtocol,
        value: Binding<F.FormatInput?>,
        format: F,
        @ViewBuilder infoContainer: () -> InfoContainer
    ) {
        self._value = value
        self.format = format
        self.label = label
        self.infoContainer = infoContainer()
    }

    public var body: some View {
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
                value: $value,
                infoContainer: infoContainer
            ) {
                textField
            }
        case .floating:
            FloatingLabel(
                title,
                value: $value,
                infoContainer: infoContainer
            ) {
                textField
            }
        }
    }

    private var textField: some View {
        Group {
            if #available(iOS 16.0, *) {
                TextField("", text: textBinding, axis: .vertical)
                    .lineLimit(expandTextAreaRange)
            } else {
                TextField("", text: textBinding)
            }
        }
        .typography(.detailBookM)
        .foregroundStyle(Color.contentNeutral01)
        .autocorrectionDisabled(true)
    }

    private func validationView(_ error: Error) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "exclamationmark.square.fill")
                .accessibilityHidden(true)
            Text(error.localizedDescription)
                .typography(.detailBookS)
                .fixedSize(horizontal: false, vertical: true)

        }
        .foregroundColor(Color.contentNegative01)
        .padding(.horizontal, 14)  // Needs to be 14px due to 2px border.
    }
}

extension InputField where InfoContainer == EmptyView {
    public init(
        _ label: any StringProtocol,
        value: Binding<F.FormatInput?>,
        format: F
    ) {
        self._value = value
        self.format = format
        self.label = label
        self.infoContainer = EmptyView()
    }
}

extension InputField where F == StringFormatStyle {
    public init(
        _ label: any StringProtocol,
        text: Binding<String>,
        @ViewBuilder infoContainer: () -> InfoContainer
    ) where F.FormatInput == String {
        self.label = label
        self._value = Binding(
            get: { text.wrappedValue },
            set: { text.wrappedValue = $0 ?? "" }
        )
        self.format = StringFormatStyle()
        self.infoContainer = infoContainer()
    }
}

extension InputField where F == StringFormatStyle, InfoContainer == EmptyView {
    public init(_ label: any StringProtocol, text: Binding<String>)
    where F.FormatInput == String {
        self.label = label
        self._value = Binding(
            get: { text.wrappedValue },
            set: { text.wrappedValue = $0 ?? "" }
        )
        self.format = StringFormatStyle()
        self.infoContainer = EmptyView()
    }
}

@available(iOS 16.0, *)
public struct InputFieldPreview: View {
    @State var supportTextEnabled = false
    @State var isOptional = true
    @State var hasError = false
    @State var text = ""
    @State var text2 = ""
    @State var money: Decimal? = 5

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    Toggle("Optional", isOn: $isOptional)
                    Toggle("Support text", isOn: $supportTextEnabled)
                    Toggle("Toggle error", isOn: $hasError)
                }
                .tint(.l3Positive01)

                Divider()

                InputField("Custom header", text: $text) {
                    Button(action: {}) {
                        Image(systemName: "info.circle")
                    }
                }
                .supportiveText(supportTextEnabled ? "Hello" : nil)
                .optionalField(isOptional)
                .applyRules(
                    to: $text,
                    rules: .maxCharacters(5)
                )

                Divider()

                InputField("Floating header 2", text: $text2)
                    .inputFieldStyle(.floating)
                    .optionalField(isOptional)
                    .applyRules(to: $text2, rules: .maxCharacters(10))

                InputField(
                    "Belopp",
                    value: $money,
                    format: .currency(code: "SEK")
                )
            }
            .padding(16)
            .animation(.default, value: hasError)
            .animation(.default, value: isOptional)
            .animation(.default, value: supportTextEnabled)
        }
        .background(Color.l1Neutral02)
    }
}

@available(iOS 16.0, *)
#Preview {
    InputFieldPreview()
}
