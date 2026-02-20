import SwiftUI

struct InfoButton: View {
    let action: () -> Void
    var body: some View {
        Button("", systemImage: "info.circle", action: action)
            .foregroundStyle(Color.contentNeutral01)
    }
}

extension EnvironmentValues {
    @Entry var inputFieldStyle: InputFieldStyle = .default
    @Entry var textInputCharacterLimit: Int?
    @Entry var optionalInput: Bool = false
    @Entry var clearButtonEnabled = false
    @Entry var supportiveText: String?
}

extension View {
    func inputFieldStyle(_ style: InputFieldStyle) -> some View {
        environment(\.inputFieldStyle, style)
    }
    
    func textInputCharacterLimit(_ limit: Int) -> some View {
        environment(\.textInputCharacterLimit, limit)
    }
    
    func optionalTextInput() -> some View {
        environment(\.optionalInput, true)
    }
    
    func clearButtonEnabled() -> some View {
        environment(\.clearButtonEnabled, true)
    }
    
    func supportiveText(_ text: String) -> some View {
        environment(\.supportiveText, text)
    }
}

enum InputFieldStyle {
    case `default`
    case floating
}

@resultBuilder
public struct AccessoryBuilder {
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }

    static func buildBlock(_ component: InfoButton) -> some View {
        component
    }
}

struct InputField<Accessory: View>: View {
    @Environment(\.inputFieldStyle) private var inputStyle
    @Environment(\.optionalInput) private var isOptionalInput

    @State private var text: String = ""  // TODO: Setup a binding text to the parent or just change this to binding depending on requirement
    private let label: any StringProtocol
    private let accessory: Accessory
    
    private var title: any StringProtocol {
        isOptionalInput ? label.appending(" (optional)") : label
    }

    init(
        _ label: any StringProtocol,
        @AccessoryBuilder accessory: () -> Accessory = AccessoryBuilder.buildBlock
    ) {
        self.label = label
        self.accessory = accessory()
    }

    var body: some View {
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
}

#Preview {
    ScrollView {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.l1Neutral02)
            
            VStack(spacing: 24) {
                InputField("Custom header") {
                    InfoButton {
                        
                    }
                }
                .inputFieldStyle(.default)
                .supportiveText("Hello")
                .optionalTextInput()
                
                Divider()
                
                InputField("Floating header 2") {
                    InfoButton {
                        
                    }
                }
                .inputFieldStyle(.floating)
            }
            .padding()
        }
    }
}
