import SwiftUI
import GdsKit

/// Green Design System toggle style that preserves the native system toggle.
public struct GdsToggleStyle: ToggleStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        Toggle(configuration)
            .tint(.l3Positive01)
    }
}

public extension ToggleStyle where Self == GdsToggleStyle {
    static var gds: GdsToggleStyle {
        GdsToggleStyle()
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        Toggle("Native with GDS tint", isOn: .constant(true))
            .toggleStyle(.gds)
        Toggle("Native with GDS tint (off)", isOn: .constant(false))
            .toggleStyle(.gds)
    }
    .padding()
}
