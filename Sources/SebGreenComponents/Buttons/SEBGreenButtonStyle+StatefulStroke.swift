import SwiftUI

public extension SEBGreenButtonStyle.Configuration {
    struct StatefulStroke {
        private let normal: Stroke?
        private let pressed: Stroke?
        private let disabled: Stroke?
        
        public init(
            normal: Stroke? = nil,
            pressed: Stroke? = nil,
            disabled: Stroke? = nil
        ) {
            self.normal = normal
            self.pressed = pressed
            self.disabled = disabled
        }
        
        public func stroke(isPressed: Bool, isDisabled: Bool) -> Stroke? {
            if isDisabled, let disabled { return disabled }
            if isPressed, let pressed { return pressed }
            return normal
        }
    }
    
    struct Stroke {
        let style: StrokeStyle
        let color: AnyShapeStyle
        
        public init(style: StrokeStyle, color: some ShapeStyle) {
            self.style = style
            self.color = AnyShapeStyle(color)
        }
    }
}
