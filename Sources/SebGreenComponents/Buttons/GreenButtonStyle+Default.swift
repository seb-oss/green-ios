import SwiftUI

/// Provides default button style configurations with preset properties.
///
/// These static properties offer quick access to commonly used button styles with standard defaults:
/// `.large` dimensions, `.fill` layout behavior, and `.leading` icon position.
public extension GreenButtonStyle {
    static var primary: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .primary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var secondary: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .secondary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var tertiary: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .tertiary,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var outline: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .outline,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var negative: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .negative,
            dimensions: .large,
            layoutBehavior: .fill,
            iconPosition: .leading
        )
    }
    
    static var notice: GreenButtonStyle {
        GreenButtonStyle(
            configuration: .notice,
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
public extension GreenButtonStyle {
    func dimensions(_ dimensions: Dimensions) -> Self {
        GreenButtonStyle(
            shape: self.shape,
            configuration: self.greenConfiguration,
            dimensions: dimensions,
            layoutBehavior: self.layoutBehavior,
            iconPosition: self.iconPosition
        )
    }
    
    func layoutBehavior(_ layoutBehavior: LayoutBehavior) -> Self {
        GreenButtonStyle(
            shape: self.shape,
            configuration: self.greenConfiguration,
            dimensions: self.dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: self.iconPosition
        )
    }
    
    func iconPosition(_ iconPosition: IconPosition) -> Self {
        GreenButtonStyle(
            shape: self.shape,
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
public extension GreenButtonStyle {
    static func primary(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .primary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func secondary(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .secondary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func tertiary(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .tertiary,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func outline(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .outline,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func negative(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .negative,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
    
    static func notice(
        shape: Shape = .pill,
        dimensions: Dimensions = .large,
        layoutBehavior: LayoutBehavior = .fill,
        iconPosition: IconPosition = .leading
    ) -> GreenButtonStyle {
        GreenButtonStyle(
            shape: shape,
            configuration: .notice,
            dimensions: dimensions,
            layoutBehavior: layoutBehavior,
            iconPosition: iconPosition
        )
    }
}
