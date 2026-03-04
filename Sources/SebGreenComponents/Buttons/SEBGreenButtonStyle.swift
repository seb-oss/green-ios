import SwiftUI
import GdsKit

// MARK: - Button Style

public struct SEBGreenButtonStyle: ButtonStyle {
    let greenConfiguration: SEBGreenButtonStyle.Configuration
    let dimensions: SEBGreenButtonStyle.Dimensions
    let layoutBehavior: SEBGreenButtonStyle.LayoutBehavior
    let iconPosition: IconPosition
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    init(
        configuration: SEBGreenButtonStyle.Configuration,
        dimensions: SEBGreenButtonStyle.Dimensions,
        layoutBehavior: SEBGreenButtonStyle.LayoutBehavior = .fill,
        iconPosition: IconPosition
    ) {
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
        
        configuration.label
            .labelStyle(.seb(.buttonLabelStyle))
            .environment(\.buttonIconPosition, iconPosition)
            .environment(\.buttonIconSpacing, dimensions.iconSpacing)
            .font(dimensions.font)
            .padding(.vertical, dimensions.verticalPadding)
            .padding(.horizontal, dimensions.horizontalPadding)
            .multilineTextAlignment(.leading)
            .foregroundStyle(effectiveForeground)
            .frame(minHeight: dimensions.height) // Visible
            .layoutBehavior(layoutBehavior)
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

extension ButtonStyle where Self == SEBGreenButtonStyle {
    static func seb(_ style: SEBGreenButtonStyle) -> some ButtonStyle  {
        style
    }
}

extension EnvironmentValues {
    @Entry var buttonIconPosition: IconPosition = .leading
    @Entry var buttonIconSpacing: CGFloat = 8
}

// MARK: - Icon Position

public enum IconPosition {
    case leading
    case trailing
}

// MARK: Layout Behavior

private extension View {
    @ViewBuilder
    func layoutBehavior(_ layoutBehavior: SEBGreenButtonStyle.LayoutBehavior) -> some View {
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
