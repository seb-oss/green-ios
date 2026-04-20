import SwiftUI

// MARK: - Default Styles

extension CalloutGroupBoxStyle {
    static var information: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: .init(hex: 0x3B3F3E),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            closeButtonPrimaryColor: .white,
            closeButtonSecondaryColor: .white.opacity(0.12),
            iconSystemName: nil
        )
    }

    static var notice: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: .init(hex: 0x2C4454),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            closeButtonPrimaryColor: .white,
            closeButtonSecondaryColor: .white.opacity(0.12),
            iconSystemName: "info.circle"
        )
    }

    static var warning: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: .init(hex: 0xA7610C),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            closeButtonPrimaryColor: .white,
            closeButtonSecondaryColor: .white.opacity(0.12),
            iconSystemName: "exclamationmark.triangle"
        )
    }

    static var critical: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: .init(hex: 0x8A230F),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            closeButtonPrimaryColor: .white,
            closeButtonSecondaryColor: .white.opacity(0.12),
            iconSystemName: "bell"
        )
    }
}

// MARK: - GroupBoxStyle Extension

extension GroupBoxStyle where Self == CalloutGroupBoxStyle {
    static func callout(_ variant: Callout.Variant) -> CalloutGroupBoxStyle {
        switch variant {
        case .information: .information
        case .notice: .notice
        case .warning: .warning
        case .critical: .critical
        }
    }
}
