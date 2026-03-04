import SwiftUI

/// Provides default button style configurations with preset properties.
///
/// These static properties offer quick access to commonly used button styles with standard defaults:
/// `.large` dimensions, `.fill` layout behavior, and `.leading` icon position.
public extension SEBGreenButtonStyle {
    static var primary: SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .primary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var secondary: SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .secondary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var tertiary: SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .tertiary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var outline: SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .outline,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var negative: SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .negative,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
}

/// Provides fluent API methods for customizing button style properties.
///
/// These instance methods allow chaining multiple customizations on an existing button style,
/// enabling a builder-pattern approach to configuration.
public extension SEBGreenButtonStyle {
    func dimensions(_ dimensions: Dimensions) -> Self {
        SEBGreenButtonStyle(
            configuration: self.greenConfiguration,
            dimensions: dimensions,
            layoutBehavior: self.layoutBehavior,
            iconPosition: self.iconPosition
        )
    }
    
    func layoutBehavior(_ layoutBehavior: LayoutBehavior) -> Self {
        SEBGreenButtonStyle(
            configuration: self.greenConfiguration,
            dimensions: self.dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: self.iconPosition
        )
    }
    
    func iconPosition(_ iconPosition: IconPosition) -> Self {
        SEBGreenButtonStyle(
            configuration: self.greenConfiguration,
            dimensions: self.dimensions,
            layoutBehavior: self.layoutBehavior,
            iconPosition: iconPosition
        )
    }
}

/// Provides static factory methods for creating customized button styles with explicit parameters.
///
/// These methods allow one-step creation of button styles with custom dimensions, layout behavior,
/// and icon positioning, while maintaining sensible defaults.
public extension SEBGreenButtonStyle {
    static func primary(
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .primary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func secondary(
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .secondary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func tertiary(
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .tertiary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func outline(
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .outline,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func negative(
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> SEBGreenButtonStyle {
        SEBGreenButtonStyle(
            configuration: .negative,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
}
