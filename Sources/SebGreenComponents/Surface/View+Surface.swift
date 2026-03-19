import SwiftUI

extension View {
    /// Sets the surface background and propagates the surface to child views.
    /// - Parameters:
    ///   - surface: The surface to apply as the background.
    ///   - level: The elevation level for the surface color.
    public func surface(
        _ surface: Surface,
        level: Level = .level1
    ) -> some View {
        self
            .background(
                .levelBased { @Sendable level, _ in
                    surface.color(for: level)
                }
            )
            .environment(\.surface, surface)
            .level(level)
    }
}
