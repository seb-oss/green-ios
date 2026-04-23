import SwiftUI

extension Callout.Variant {
    struct CloseButtonColors {
        let primary: Color
        let secondary: Color
    }

    func closeButtonColors(surface: Surface) -> CloseButtonColors {
        switch self {
        case .information(.subtle):
            CloseButtonColors(
                primary: .contentNeutral02,
                secondary:
                    surface == .neutral01 ? .l3Neutral01 : .l3Neutral02
            )
        case .information(.loud), .notice, .warning, .critical:
            CloseButtonColors(
                primary: .white,  // TODO: Should be contentNeutral05
                secondary: .white.opacity(0.12)
            )
        }
    }
}
