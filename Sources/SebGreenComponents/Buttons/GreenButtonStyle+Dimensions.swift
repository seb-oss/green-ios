import SwiftUI
import GdsKit

public extension GreenButtonStyle {
    struct Dimensions: Equatable {
        let height: CGFloat
        let verticalPadding: CGFloat
        let horizontalPadding: CGFloat
        var font: Font = .gds(.detailMBook)
        let iconSpacing: CGFloat
        let maxCornerRadius: CGFloat
        
        var cornerRadius: CGFloat { min(maxCornerRadius, height / 2) }
        
        init(
            height: CGFloat,
            verticalPadding: CGFloat,
            horizontalPadding: CGFloat,
            font: Font? = nil,
            iconSpacing: CGFloat = .gds(.spaceXs),
            maxCornerRadius: CGFloat = 28.0
        ) {
            if let font {
                self.font = font
            }
            self.height = height
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
            self.iconSpacing = iconSpacing
            self.maxCornerRadius = maxCornerRadius
        }
    }
}

public extension GreenButtonStyle.Dimensions {
    static let small = Self(
        height: 32.0,
        verticalPadding: .gds(.space3xs),
        horizontalPadding: .gds(.spaceM),
        font: .gds(.detailSBook),
        iconSpacing: .gds(.space3xs)
    )
    
    static let medium = Self(
        height: 44.0,
        verticalPadding: .gds(.spaceXs),
        horizontalPadding: .gds(.spaceM),
        iconSpacing: .gds(.space2xs)
    )
    
    static let large = Self(
        height: 48.0,
        verticalPadding: .gds(.spaceS),
        horizontalPadding: .gds(.spaceM),
        iconSpacing: .gds(.spaceXs)
    )
    
    static let xlarge = Self(
        height: 56.0,
        verticalPadding: .gds(.spaceM),
        horizontalPadding: .gds(.spaceM),
        iconSpacing: .gds(.spaceXs)
    )
}

extension GreenButtonStyle.Dimensions: CustomStringConvertible {
    public var description: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .xlarge: return "X-Large"
        default: return "Custom"
        }
    }
}
