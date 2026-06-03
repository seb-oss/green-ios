import SwiftUI
import GdsKit

// MARK: - Button Style

public struct GreenButtonStyle: ButtonStyle {
    let shape: Shape
    let greenConfiguration: GreenButtonStyle.Configuration
    let dimensions: GreenButtonStyle.Dimensions
    let layoutBehavior: GreenButtonStyle.LayoutBehavior
    let iconPosition: IconPosition
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    init(
        shape: Shape = .pill,
        configuration: GreenButtonStyle.Configuration,
        dimensions: GreenButtonStyle.Dimensions,
        layoutBehavior: GreenButtonStyle.LayoutBehavior = .fill,
        iconPosition: IconPosition
    ) {
        self.shape = shape
        self.greenConfiguration = configuration
        self.dimensions = dimensions
        self.layoutBehavior = layoutBehavior
        self.iconPosition = iconPosition
    }
    
    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        let greenConfiguration = greenConfiguration
        
        let effectiveForeground = greenConfiguration.foreground.style(
            isPressed: configuration.isPressed,
            isDisabled: !isEnabled
        )
        let normalBackground = greenConfiguration.background.style(
            isPressed: false,
            isDisabled: !isEnabled
        )
        let pressedBackground = greenConfiguration.background.style(
            isPressed: configuration.isPressed,
            isDisabled: !isEnabled
        )
        let effectiveStroke = greenConfiguration.stroke?.stroke(
            isPressed: configuration.isPressed,
            isDisabled: !isEnabled
        )
        
        let cornerRadius = dimensions.cornerRadius
        
        let buttonLabelStyle = GreenLabelStyle.buttonLabelStyle(
            iconPosition: iconPosition,
            iconSpacing: dimensions.iconSpacing
        )
        
        configuration.label
            .labelStyle(.gds(buttonLabelStyle))
            .font(dimensions.font)
            .padding(.vertical, dimensions.verticalPadding)
            .padding(.horizontal, shape.isPill ? dimensions.horizontalPadding : nil)
            .multilineTextAlignment(.leading)
            .foregroundStyle(effectiveForeground)
            .frame(width: shape.isCircle ? dimensions.height : nil)
            .frame(minHeight: dimensions.height) // Visible
            .layoutBehavior(shape.isCircle ? .hug : layoutBehavior) 
            .background {
                // Pressed background overlays on top when pressed and enabled
                if configuration.isPressed && isEnabled {
                    RoundedRectangle(cornerRadius: dimensions.cornerRadius)
                        .fill(pressedBackground)
                }
            }
            .background(
                normalBackground,
                in: .rect(cornerRadius: cornerRadius)
            )
            .overlay {
                if let stroke = effectiveStroke {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(stroke.color, style: stroke.style)
                }
            }
            .frame(minHeight: 44) // Touch area
            .contentShape(.rect)
            .animation(.easeInOut(duration: 0.16), value: isEnabled)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

extension GreenButtonStyle {
    public enum Shape {
        case pill
        case circle
        
        var isPill: Bool {
            switch self {
            case .circle: return false
            case .pill: return true
            }
        }
        
        var isCircle: Bool {
            switch self {
            case .circle: return true
            case .pill: return false
            }
        }
    }
}

public extension ButtonStyle where Self == GreenButtonStyle {
    static func gds(_ style: GreenButtonStyle) -> Self {
        style
    }
}

// MARK: - Icon Position

public enum IconPosition {
    case leading
    case trailing
}

// MARK: Layout Behavior

private extension View {
    @ViewBuilder
    func layoutBehavior(_ layoutBehavior: GreenButtonStyle.LayoutBehavior) -> some View {
        switch layoutBehavior {
        case .fill:
            self.frame(maxWidth: .infinity)
        case .hug:
            self // Natural sizing - respects parent bounds and allows wrapping
        case .fixed(let width):
            self.frame(width: width)
        case .flexible(let min, let max):
            self.frame(minWidth: min, maxWidth: max)
        }
    }
}
