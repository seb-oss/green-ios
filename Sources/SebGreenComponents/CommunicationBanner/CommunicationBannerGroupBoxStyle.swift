import SwiftUI

struct CommunicationBannerGroupBoxStyle: GroupBoxStyle {
    let variant: CommunicationBanner.Variant
    let onClose: (() -> Void)?

    private var style: CommunicationBanner.Variant.Style {
        switch variant {
        case .information: .information
        case .notice: .notice
        case .warning: .warning
        case .error: .error
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: .spaceS) {
            rail

            VStack(alignment: .leading, spacing: .space3xs) {
                configuration.label
                    .typography(.detailBookM)
                    .foregroundStyle(style.textColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.trailing, .spaceM)

                configuration.content
                    .typography(.bodyRegularS)
                    .foregroundStyle(style.textColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, .spaceM)
        }
        .padding(.leading, .space2xs)
        .padding(.trailing, .spaceM)
        .background(
            style.backgroundColor,
            in: .rect(cornerRadius: .cornerRadius)
        )
        .overlay {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(
                    style.borderColor,
                    lineWidth: .cornerRadiusLightWidth
                )
        }
        .overlay(alignment: .topTrailing) {
            if let onClose {
                closeButton(onClose: onClose)
            }
        }
    }

    private var rail: some View {
        style.railColor
            .overlay {
                Icon(systemName: style.iconSystemName)
                    .foregroundStyle(style.iconColor)
                    .accessibilityHidden(true)
            }
            .frame(width: .space4xl)
            .clipShape(railShape)
            .padding(.vertical, .space2xs)
    }

    private func closeButton(onClose: @escaping () -> Void) -> some View {
        Button(systemName: "xmark.circle.fill", action: onClose)
            .foregroundStyle(
                style.closeButtonPrimaryColor,
                style.closeButtonSecondaryColor
            )
            .contentShape(.circle)
            .accessibilityLabel("Close")
            .padding([.top, .trailing], .spaceXs)
    }

    private var railShape: some Shape {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
    }
}

extension GroupBoxStyle where Self == CommunicationBannerGroupBoxStyle {
    static func communicationBanner(
        variant: CommunicationBanner.Variant,
        onClose: (() -> Void)?
    ) -> CommunicationBannerGroupBoxStyle {
        CommunicationBannerGroupBoxStyle(variant: variant, onClose: onClose)
    }
}

private extension CommunicationBanner.Variant {
    struct Style {
        let backgroundColor: Color
        let borderColor: Color
        let railColor: Color
        let iconColor: Color
        let textColor: Color
        let closeButtonPrimaryColor: Color
        let closeButtonSecondaryColor: Color
        let iconSystemName: String
        let shouldAutoFocus: Bool
    }
}

extension CommunicationBanner.Variant.Style {
    static var information: Self = .init(
        backgroundColor: .l2Neutral02,
        borderColor: .clear,
        railColor: .l2Information01,
        iconColor: .contentNeutral02,
        textColor: .contentNeutral01,
        closeButtonPrimaryColor: .contentNeutral02,
        closeButtonSecondaryColor: .l3Neutral02,
        iconSystemName: "info.circle",
        shouldAutoFocus: false
    )

    static var notice: Self = .init(
        backgroundColor: .l2Neutral02,
        borderColor: .clear,
        railColor: .l2Notice01,
        iconColor: .contentNotice01,
        textColor: .contentNeutral01,
        closeButtonPrimaryColor: .contentNeutral02,
        closeButtonSecondaryColor: .l3Neutral02,
        iconSystemName: "megaphone",
        shouldAutoFocus: false
    )

    static var warning: Self = .init(
        backgroundColor: .l2Neutral02,
        borderColor: .clear,
        railColor: .l2Warning01,
        iconColor: .contentWarning01,
        textColor: .contentNeutral01,
        closeButtonPrimaryColor: .contentNeutral02,
        closeButtonSecondaryColor: .l3Neutral02,
        iconSystemName: "exclamationmark.triangle",
        shouldAutoFocus: true
    )

    static var error: Self = .init(
        backgroundColor: .l2Neutral02,
        borderColor: .clear,
        railColor: .l2Negative01,
        iconColor: .contentNegative01,
        textColor: .contentNeutral01,
        closeButtonPrimaryColor: .contentNeutral02,
        closeButtonSecondaryColor: .l3Neutral02,
        iconSystemName: "exclamationmark.triangle",
        shouldAutoFocus: true
    )
}

// MARK: - Design tokens

extension CGFloat {
    static let cornerRadius = 12.0
    static let cornerRadiusLightWidth = 1.5
}
