import SwiftUI

public typealias LevelColorProvider = @Sendable (Level, UIUserInterfaceLevel) -> Color

public struct LevelBasedColor: ShapeStyle {
    private let colorForLevel: LevelColorProvider

    public init(_ colorForLevel: @escaping LevelColorProvider) {
        self.colorForLevel = colorForLevel
    }

    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        colorForLevel(environment.level, environment.userInterfaceLevel)
    }
}

extension ShapeStyle where Self == LevelBasedColor {
    public static func levelBased(_ colorForLevel: @escaping LevelColorProvider) -> LevelBasedColor {
        LevelBasedColor(colorForLevel)
    }
}
