import SwiftUI

extension CalloutGroupBoxStyle {
    static var information: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.surfaceAware),
            borderColor: .gds(.borderNeutral02),
            iconColor: .gds(.contentNeutral01),
            textColor: .gds(.contentNeutral01),
            iconSystemName: nil
        )
    }

    static var informationLoud: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.gds(.l2Neutral04, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            iconSystemName: nil
        )
    }

    static var notice: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempNotice, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            iconSystemName: "info.circle"
        )
    }

    static var warning: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempWarning, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            iconSystemName: "exclamationmark.triangle"
        )
    }

    static var critical: CalloutGroupBoxStyle {
        CalloutGroupBoxStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempCritical, bundle: .module)),
            borderColor: .clear,
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
