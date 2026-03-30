//
// Copyright © 2026 Skandinaviska Enskilda Banken AB (publ). All rights reserved.
//

import GdsKit
import SwiftUI

public struct InformationMessageView: View {
    public enum Variant: CaseIterable, Equatable {
        case information
        case notice
        case warning
        case error
    }

    public struct Model: Equatable {
        public let title: String
        public let message: String
        public let variant: Variant

        public init(
            title: String,
            message: String,
            variant: Variant
        ) {
            self.title = title
            self.message = message
            self.variant = variant
        }
    }

    public struct Actions {
        public struct CallToAction {
            public enum LinkStyle: Equatable {
                case internalLink
                case externalLink

                fileprivate var symbolName: String {
                    switch self {
                    case .internalLink:
                        return "arrow.right"
                    case .externalLink:
                        return "arrow.up.right"
                    }
                }
            }

            public let title: String
            public let linkStyle: LinkStyle?
            public let action: () -> Void

            public init(
                title: String,
                linkStyle: LinkStyle? = nil,
                action: @escaping () -> Void
            ) {
                self.title = title
                self.linkStyle = linkStyle
                self.action = action
            }
        }

        public let onClose: (() -> Void)?
        public let callToAction: CallToAction?

        public init(
            onClose: (() -> Void)? = nil,
            callToAction: CallToAction? = nil
        ) {
            self.onClose = onClose
            self.callToAction = callToAction
        }
    }

    private let model: Model
    private let actions: Actions
    @AccessibilityFocusState private var accessibilityFocus: Bool

    public init(
        model: Model,
        actions: Actions = .init()
    ) {
        self.model = model
        self.actions = actions
    }

    public var body: some View {
        HStack(alignment: .top, spacing: .spaceS) {
            rail

            VStack(alignment: .leading, spacing: .space3xs) {
                titleView
                messageView
                callToActionView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, .spaceM)
            .padding(.trailing, trailingPadding)
            .accessibilityElement(children: .contain)
            .accessibilityFocused($accessibilityFocus)
        }
        .padding(.leading, .space2xs)
        .background(variantStyle.backgroundColor)
        .clipShape(cardShape)
        .overlay(alignment: .topTrailing) {
            closeButton
        }
        .overlay {
            cardShape
                .stroke(variantStyle.borderColor, lineWidth: 1)
        }
        .onAppear {
            accessibilityFocus = variantStyle.shouldAutoFocus
        }
    }

    private var rail: some View {
        variantStyle.railColor
            .overlay {
                Icon(systemName: variantStyle.iconSystemName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(variantStyle.iconColor)
                    .accessibilityHidden(true)
            }
            .frame(width: .space4xl)
            .clipShape(railShape)
            .padding(.vertical, .space2xs)
    }

    private var titleView: some View {
        Text(model.title)
            .typography(.detailBookM)
            .foregroundStyle(variantStyle.textColor)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var messageView: some View {
        Text(model.message)
            .typography(.bodyRegularS)
            .foregroundStyle(variantStyle.textColor)
            .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private var callToActionView: some View {
        if let callToAction = actions.callToAction {
            GreenButton(
                title: callToAction.title,
                kind: .tertiary,
                size: .small,
                icon: callToAction.linkStyle.map { Image(systemName: $0.symbolName) },
                iconPosition: .trailing,
                action: callToAction.action
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, .space2xs)
        }
    }

    @ViewBuilder
    private var closeButton: some View {
        if let onClose = actions.onClose {
            Button(action: onClose) {
                Image(systemName: "xmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(variantStyle.closeButtonPrimaryColor, variantStyle.closeButtonSecondaryColor)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(.spaceXs)
            .accessibilityLabel("Close")
        }
    }

    private var trailingPadding: CGFloat {
        actions.onClose == nil ? .spaceM : .space4xl + .spaceXs
    }

    private var variantStyle: VariantStyle {
        VariantStyle(variant: model.variant)
    }

    private var cardShape: some Shape {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
    }

    private var railShape: some Shape {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
    }
}

private struct VariantStyle {
    let backgroundColor: Color
    let borderColor: Color
    let railColor: Color
    let iconColor: Color
    let textColor: Color
    let closeButtonPrimaryColor: Color
    let closeButtonSecondaryColor: Color
    let iconSystemName: String
    let shouldAutoFocus: Bool

    init(variant: InformationMessageView.Variant) {
        switch variant {
        case .information:
            backgroundColor = .l2Neutral02
            borderColor = .clear
            railColor = .l2Information01
            iconColor = .contentNeutral02
            textColor = .contentNeutral01
            closeButtonPrimaryColor = .contentNeutral02
            closeButtonSecondaryColor = .l3Neutral02
            iconSystemName = "info.circle"
            shouldAutoFocus = false
        case .notice:
            backgroundColor = .l2Neutral02
            borderColor = .clear
            railColor = .l2Notice01
            iconColor = .contentNotice01
            textColor = .contentNeutral01
            closeButtonPrimaryColor = .contentNeutral02
            closeButtonSecondaryColor = .l3Neutral02
            iconSystemName = "megaphone"
            shouldAutoFocus = false
        case .warning:
            backgroundColor = .l2Neutral02
            borderColor = .clear
            railColor = .l2Warning01
            iconColor = .contentWarning01
            textColor = .contentNeutral01
            closeButtonPrimaryColor = .contentNeutral02
            closeButtonSecondaryColor = .l3Neutral02
            iconSystemName = "exclamationmark.triangle"
            shouldAutoFocus = true
        case .error:
            backgroundColor = .l2Neutral02
            borderColor = .clear
            railColor = .l2Negative01
            iconColor = .contentNegative01
            textColor = .contentNeutral01
            closeButtonPrimaryColor = .contentNeutral02
            closeButtonSecondaryColor = .l3Neutral02
            iconSystemName = "exclamationmark.triangle"
            shouldAutoFocus = true
        }
    }
}

#Preview("InformationMessageView") {
    ScrollView {
        VStack(alignment: .leading, spacing: .spaceM) {
            InformationMessageView(
                model: .init(
                    title: "Information",
                    message: "Used for passive, non-critical updates like tips or background information.",
                    variant: .information
                ),
                actions: .init(onClose: {})
            )
            InformationMessageView(
                model: .init(
                    title: "Notice",
                    message: "Used for actionable, attention-worthy updates that are still non-critical.",
                    variant: .notice
                ),
                actions: .init(
                    onClose: {},
                    callToAction: .init(
                        title: "See details",
                        linkStyle: .internalLink,
                        action: {}
                    )
                )
            )

            InformationMessageView(
                model: .init(
                    title: "Warning",
                    message: "Used to highlight important risks or information related to surrounding context.",
                    variant: .warning
                ),
                actions: .init(
                    callToAction: .init(
                        title: "Read more",
                        linkStyle: .externalLink,
                        action: {}
                    )
                )
            )

            InformationMessageView(
                model: .init(
                    title: "Error",
                    message: "Used to communicate that something has gone wrong or does not work and needs user attention.",
                    variant: .error
                ),
                actions: .init(onClose: {})
            )
        }
        .padding(.spaceM)
    }
    .surface(.neutral02)
}

