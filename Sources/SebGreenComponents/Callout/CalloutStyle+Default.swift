import SwiftUI

extension CalloutStyle {
    static var information: CalloutStyle {
        CalloutStyle(
            backgroundColor: AnyShapeStyle(.surfaceAware),
            borderColor: .gds(.borderNeutral02),
            iconColor: .gds(.contentNeutral01),
            textColor: .gds(.contentNeutral01),
            severityIcon: nil
        )
    }

    static var informationLoud: CalloutStyle {
        CalloutStyle(
            backgroundColor: AnyShapeStyle(.gds(.l2Neutral04, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            severityIcon: nil
        )
    }

    static var notice: CalloutStyle {
        CalloutStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempNotice, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            severityIcon: .init(
                iconSystemName: "info.circle",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Notice", bundle: .module)
            )
        )
    }

    static var warning: CalloutStyle {
        CalloutStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempWarning, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            severityIcon: .init(
                iconSystemName: "exclamationmark.triangle",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Warning", bundle: .module)
            )
        )
    }

    static var critical: CalloutStyle {
        CalloutStyle(
            backgroundColor: AnyShapeStyle(.gds(.tempCritical, bundle: .module)),
            borderColor: .clear,
            iconColor: .white,
            textColor: .white,
            severityIcon: .init(
                iconSystemName: "bell",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Critical", bundle: .module)
            )
        )
    }
}

extension CalloutStyle {
    static func callout(_ variant: Callout.Variant) -> CalloutStyle {
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
