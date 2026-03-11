import SwiftUI

// Testing override for focus visibility, which is otherwise determined by the system and cannot be overridden in tests.
extension EnvironmentValues {
    @Entry var overrideFocusVisibility = false
}

package extension View {
    func overrideFocusVisibility() -> some View {
        environment(\.overrideFocusVisibility, true)
    }
}
