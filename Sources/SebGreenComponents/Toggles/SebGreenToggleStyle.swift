import SwiftUI
import GdsKit

@available(*, deprecated, message: "SebGreenToggleStyle is obsolete. Use native Toggle with .gdsToggleTint() instead.")
public typealias SebGreenToggleStyle = Never

@available(*, deprecated, message: "GreenCapsuleToggleStyle is obsolete. Use native Toggle with .gdsToggleTint() instead.")
public struct GreenCapsuleToggleStyle: ToggleStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        // Fallback: render native Toggle and apply the new modifier to avoid build breaks.
        Toggle(isOn: configuration.$isOn) { configuration.label }
            .gdsToggleTint()
    }
}

@available(*, deprecated, message: "SystemSwitchToggleStyle is obsolete. Use native Toggle with .gdsToggleTint() instead.")
public struct SystemSwitchToggleStyle: ToggleStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        Toggle(isOn: configuration.$isOn) { configuration.label }
            .gdsToggleTint()
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        Toggle("Native with GDS tint", isOn: .constant(true))
            .gdsToggleTint()
        Toggle("Native with GDS tint (off)", isOn: .constant(false))
            .gdsToggleTint()
    }
    .padding()
}
