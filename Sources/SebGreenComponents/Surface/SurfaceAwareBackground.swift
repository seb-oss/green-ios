import SwiftUI

/// A `ShapeStyle` that resolves the background color
/// based on the parent's `Level` and `Surface` from the environment.
public struct SurfaceAwareBackground: ShapeStyle {
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        let level = environment.level.above
        let surface = environment.surface
        return surface.color(for: level)
    }
}

extension ShapeStyle where Self == SurfaceAwareBackground {
    /// A background style that automatically resolves the correct color
    /// based on the parent view's `Level` and `Surface` environment values.
    public static var surfaceAware: SurfaceAwareBackground {
        SurfaceAwareBackground()
    }
}
