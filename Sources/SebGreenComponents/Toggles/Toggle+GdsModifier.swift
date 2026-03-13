import SwiftUI
import GdsKit

/// Green Design System — Toggle convenience modifier
/// Use on any Toggle to apply the agreed native appearance with the system switch
/// tinted using the GDS positive brand color.
///
/// Centralize the toggle tint in one place so changes propagate project-wide.
public extension Toggle {
    /// Applies the Green Design System tint color to the native Toggle.
    ///
    /// Example:
    /// Toggle("Notifications", isOn: $isOn)
    ///     .gdsToggleTint()
    func gdsToggleTint() -> some View {
        self.tint(.l3Positive01)
    }
}
