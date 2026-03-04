import SwiftUI

// MARK: - Style

public extension SEBGreenButtonStyle.Configuration {
    struct StatefulStyle {
        private let normal: AnyShapeStyle
        private let pressed: AnyShapeStyle?
        private let disabled: AnyShapeStyle?
        
        public init(normal: some ShapeStyle) {
            self.normal = AnyShapeStyle(normal)
            self.pressed = nil
            self.disabled = nil
        }
        
        public init(
            normal: some ShapeStyle,
            pressed: some ShapeStyle
        ) {
            self.normal = AnyShapeStyle(normal)
            self.pressed = AnyShapeStyle(pressed)
            self.disabled = nil
        }
        
        public init(
            normal: some ShapeStyle,
            disabled: some ShapeStyle
        ) {
            self.normal = AnyShapeStyle(normal)
            self.pressed = nil
            self.disabled = AnyShapeStyle(disabled)
        }
        
        public init(
            normal: some ShapeStyle,
            pressed: some ShapeStyle,
            disabled: some ShapeStyle
        ) {
            self.normal = AnyShapeStyle(normal)
            self.pressed = AnyShapeStyle(pressed)
            self.disabled = AnyShapeStyle(disabled)
        }
        
        public func style(isPressed: Bool, isDisabled: Bool) -> AnyShapeStyle {
            if isDisabled, let disabled { return disabled }
            if isPressed, let pressed { return pressed }
            return normal
        }
    }

}
