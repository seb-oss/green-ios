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

    /// Sets the sheet presentation background and propagates the surface to child views.
    /// - Parameters:
    ///   - surface: The surface to apply as the presentation background.
    ///   - level: The elevation level for the surface color. Defaults to `.level2`.
    @available(iOS 16.4, *)
    public func presentationSurface(
        _ surface: Surface,
        level: Level = .level2
    ) -> some View {
        self
            .presentationBackground(
                .levelBased { @Sendable level, _ in
                    surface.color(for: level)
                }
            )
            .environment(\.surface, surface)
            .level(level)
    }
}
