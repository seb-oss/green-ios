import SwiftUI

// TODO: Remove later
struct InfoButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle")
                .foregroundStyle(Color.contentNeutral01)
        }
    }
}

enum InputFieldStyle {
    case `default`
    case floating
}

// TODO: Add sensory feedback for hard + soft validation
enum CharacterLimit {
    case hard(limit: Int)
    case soft(limit: Int)

    var limit: Int {
        switch self {
        case .hard(let limit): limit
        case .soft(let limit): limit
        }
    }

    enum Error: LocalizedError {
        case reachedLimit

        var errorDescription: String? {
            switch self {
            case .reachedLimit:
                String(localized: "GreeniOS.Error.ReachedLimit")
            }
        }
    }
}

struct InputField<InfoContainer: View>: View {
    @Environment(\.inputFieldStyle) private var inputStyle
    @Environment(\.optionalField) private var optionalField
    @Environment(\.validationError) private var validationError
    @Environment(\.expandTextAreaRange) private var expandTextAreaRange

    @Binding private var text: String
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

    init(
        _ label: any StringProtocol,
        text: Binding<String>,
        @ViewBuilder infoContainer: () -> InfoContainer
    ) {
        self.label = label
        self._text = text
        self.infoContainer = infoContainer()
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
                infoContainer: infoContainer
            ) {
                textField
            }
        case .floating:
            FloatingLabel(
                title,
                text: $text,
                infoContainer: infoContainer
            ) {
                textField
            }
        }
    }

    private var textField: some View {
        Group {
            if #available(iOS 16.0, *) {
                TextField("", text: $text, axis: .vertical)
                    .lineLimit(expandTextAreaRange)
            } else {
                TextField("", text: $text)
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
    init(_ label: any StringProtocol, text: Binding<String>) {
        self.label = label
        self._text = text
        self.infoContainer = EmptyView()
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var supportTextEnabled = false
    @Previewable @State var isOptional = false
    @Previewable @State var hasError = false

    @Previewable @State var text = ""
    @Previewable @State var text2 = ""

    ScrollView {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.l1Neutral02)

            VStack(spacing: 24) {
                VStack {
                    Toggle("Optional", isOn: $isOptional)
                    Toggle("Support text", isOn: $supportTextEnabled)
                    Toggle("Toggle error", isOn: $hasError)
                }

                Divider()

                InputField("Custom header", text: $text) {
                    InfoButton {}
                }
                .supportiveText(supportTextEnabled ? "Hello" : nil)
                .optionalField(isOptional)
                .validation(
                    hasError ? NSError(domain: "", code: 999) : nil
                )
                .textInputCharacterLimit(.soft(limit: 50))

                Divider()

                InputField("Floating header 2", text: $text2)
                    .inputFieldStyle(.floating)
                    .optionalField(isOptional)
                    .validation(
                        hasError ? NSError(domain: "", code: 999) : nil
                    )
                    .textInputCharacterLimit(.soft(limit: 50))

                TextField("", text: .constant(""))
            }
            .padding(16)
        }
        .animation(.default, value: hasError)
        .animation(.default, value: isOptional)
        .animation(.default, value: supportTextEnabled)
    }
}
