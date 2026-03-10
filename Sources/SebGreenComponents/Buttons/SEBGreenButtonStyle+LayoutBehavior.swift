import SwiftUI

public extension SEBGreenButtonStyle {
    enum LayoutBehavior: Equatable {
        case fill
        case hug
        case fixed(CGFloat)
        case flexible(min: CGFloat? = nil, max: CGFloat? = nil)
    }
}

extension SEBGreenButtonStyle.LayoutBehavior: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fill:
            return "Fill"
        case .hug:
            return "Hug"
        case .fixed(let width):
            return "Fixed (\(Int(width)))"
        case .flexible(let min, let max):
            let minStr = min.map { "\(Int($0))" } ?? "nil"
            let maxStr = max.map { "\(Int($0))" } ?? "nil"
            return "Flexible (\(minStr)-\(maxStr))"
        }
    }
}
