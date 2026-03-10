import SwiftUI
import GdsKit

public extension SEBGreenButtonStyle {
    struct Dimensions: Equatable {
        let height: CGFloat
        let verticalPadding: CGFloat
        let horizontalPadding: CGFloat
        var font: Font = .seb(.detailBookM)
        let iconSpacing: CGFloat
        let maxCornerRadius: CGFloat
        
        var cornerRadius: CGFloat { min(maxCornerRadius, height / 2) }
        
        init(
            height: CGFloat,
            verticalPadding: CGFloat,
            horizontalPadding: CGFloat,
            font: Font? = nil,
            iconSpacing: CGFloat = 8,
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

public extension SEBGreenButtonStyle.Dimensions {
    static let small = Self(
        height: 32.0,
        verticalPadding: .space3xs,
        horizontalPadding: .spaceM,
        font: .seb(.detailBookS),
        iconSpacing: 4
    )
    
    static let medium = Self(
        height: 44.0,
        verticalPadding: .spaceXs,
        horizontalPadding: .spaceM,
        iconSpacing: 6
    )
    
    static let large = Self(
        height: 48.0,
        verticalPadding: .spaceS,
        horizontalPadding: .spaceM,
        iconSpacing: 8
    )
    
    static let xlarge = Self(
        height: 56.0,
        verticalPadding: .spaceM,
        horizontalPadding: .spaceM,
        iconSpacing: 8
    )
}

extension SEBGreenButtonStyle.Dimensions: CustomStringConvertible {
    public var description: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .xlarge: return "X-Large"
        default:
            fatalError()
        }
    }
}
