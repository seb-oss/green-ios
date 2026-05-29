import SwiftUI

extension CalloutAppearance {
    static var information: CalloutAppearance {
        CalloutAppearance(
            backgroundColor: AnyShapeStyle(.surfaceAware),
            borderColor: .gds(.borderNeutral02),
            iconColor: .gds(.contentNeutral01),
            textColor: .gds(.contentNeutral01),
            severityIcon: nil,
            primaryActionStyle: .secondary(dimensions: .small, iconPosition: .trailing),
            closeButtonColors: { surface in
                .init(
                    primary: .gds(.contentNeutral02),
                    secondary: .gds(surface == .neutral01 ? .l3Neutral01 : .l3Neutral02)
                )
            }
        )
    }

    static var informationLoud: CalloutAppearance {
        CalloutAppearance(
            backgroundColor: AnyShapeStyle(.gds(.l2Neutral04, bundle: .module)),
            severityIcon: nil,
        )
    }

    static var notice: CalloutAppearance {
        CalloutAppearance(
            backgroundColor: AnyShapeStyle(.gds(.tempNotice, bundle: .module)),
            severityIcon: .init(
                iconSystemName: "info.circle",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Notice", bundle: .module)
            )
        )
    }

    static var warning: CalloutAppearance {
        CalloutAppearance(
            backgroundColor: AnyShapeStyle(.gds(.tempWarning, bundle: .module)),
            severityIcon: .init(
                iconSystemName: "exclamationmark.triangle",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Warning", bundle: .module)
            )
        )
    }

    static var critical: CalloutAppearance {
        CalloutAppearance(
            backgroundColor: AnyShapeStyle(.gds(.tempCritical, bundle: .module)),
            severityIcon: .init(
                iconSystemName: "bell",
                accessibilitySeverityLabel: String(localized: "GreeniOS.Callout.Accessibility.Severity.Critical", bundle: .module)
            )
        )
    }
}

extension CalloutAppearance {
    static func appearance(for variant: Callout.Variant) -> CalloutAppearance {
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
    @Entry var calloutAppearance: CalloutAppearance = .information
}

extension View {
    /// Sets the visual variant of the callout.
    public func calloutStyle(_ variant: Callout.Variant) -> some View {
        environment(\.calloutAppearance, .appearance(for: variant))
    }
}
