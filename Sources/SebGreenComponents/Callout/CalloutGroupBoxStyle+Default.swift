import SwiftUI

extension CalloutGroupBoxStyle {
    static var information: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.surfaceAware),
            ignoreBackgroundOpacity: true,
            borderColor: .borderSubtle01,
            shouldShowBorder: { $0 == .neutral02 },
            iconColor: .contentNeutral01,
            textColor: .contentNeutral01,
            iconSystemName: nil
        )
    }

    static var informationLoud: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(Color.l2NeutralLoud),
            ignoreBackgroundOpacity: false,
            borderColor: .clear,
            shouldShowBorder: { _ in false },
            iconColor: .white,
            textColor: .white,
            iconSystemName: nil
        )
    }

    static var notice: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(Color(hex: 0x2C4454)),
            ignoreBackgroundOpacity: false,
            borderColor: .clear,
            shouldShowBorder: { _ in false },
            iconColor: .white,
            textColor: .white,
            iconSystemName: "info.circle"
        )
    }

    static var warning: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(Color(hex: 0xA7610C)),
            ignoreBackgroundOpacity: false,
            borderColor: .clear,
            shouldShowBorder: { _ in false },
            iconColor: .white,
            textColor: .white,
            iconSystemName: "exclamationmark.triangle"
        )
    }

    static var critical: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(Color(hex: 0x8A230F)),
            ignoreBackgroundOpacity: false,
            borderColor: .clear,
            shouldShowBorder: { _ in false },
            iconColor: .white,
            textColor: .white,
            iconSystemName: "bell"
        )
    }
}

extension GroupBoxStyle where Self == CalloutGroupBoxStyle {
    public static func callout(
        _ variant: Callout.Variant
    ) -> CalloutGroupBoxStyle {
        switch variant {
        case .information(.subtle): .information
        case .information(.loud): .informationLoud
        case .notice: .notice
        case .warning: .warning
        case .critical: .critical
        }
    }
}


extension EnvironmentValues {
    @Entry var calloutStyle: Callout.Variant = .information(.subtle)
}

extension View {
    public func calloutStyle(_ style: Callout.Variant) -> some View {
        environment(\.calloutStyle, style)
    }
}
