//
//  InfoCard.swift
//  SebGreenComponents
//
//

import SwiftUI

public struct InfoCardView: View {
    public struct Variant: Equatable {
        public let backgroundColor: Color
        public let borderColor: Color
        public let closeButtonBackgroundColor: Color
        public let closeButtonColor: Color
        public let textForegroundColor: Color
        
        init(
            backgroundColor: Color,
            borderColor: Color,
            closeButtonBackgroundColor: Color,
            closeButtonColor: Color,
            textForegroundColor: Color
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.closeButtonBackgroundColor = closeButtonBackgroundColor
            self.closeButtonColor = closeButtonColor
            self.textForegroundColor = textForegroundColor
        }

        public static let information = Variant(
            backgroundColor: .l2Neutral02,
            borderColor: .borderInformation02,
            closeButtonBackgroundColor: .l3Neutral02,
            closeButtonColor: .contentNeutral02,
            textForegroundColor: .contentNeutral01
        )

        public static let informationHd = Variant(
            backgroundColor: .l2NeutralLoud,
            borderColor: .clear,
            closeButtonBackgroundColor: .l3NeutralTone,
            closeButtonColor: .contentInversed,
            textForegroundColor: .contentInversed
        )
    }
    
    // MARK: - Model
    public struct Model: Equatable {
        public var title: String
        public var message: String
        public var variant: Variant
        
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
    
    // MARK: - Actions
    public struct Actions {
        public struct CallToAction {
            public var title: String
            public var action: () -> Void
            
            public init(
                title: String,
                action: @escaping () -> Void
            ) {
                self.title = title
                self.action = action
            }
        }
        public var onClose: (() -> Void)?
        public var callToAction: CallToAction?
        public var onTap: (() -> Void)?
        
        public init(
            onClose: (() -> Void)? = nil,
            onTap: (() -> Void)? = nil,
            callToAction: CallToAction? = nil
        ) {
            self.onClose = onClose
            self.callToAction = callToAction
            self.onTap = onTap
        }
    }
    
    private let model: Model
    private let actions: Actions
    
    public init(model: Model, actions: Actions = .init()) {
        self.model = model
        self.actions = actions
    }
    
    public var body: some View {
        card
    }
    
    private var card: some View {
        ZStack(alignment: .topTrailing) {
            cardContent
                .onTapIfAvailable(actions.onTap)
            
            closeButton
        }
    }
    
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: .space3xs) {
            titleView
            messageView
            callToActionView
        }
        .padding(.spaceM)
        .background(model.variant.backgroundColor)
        .clipShape(cardShape)
        .overlay(cardBorder)
        .accessibilityElement(children: .contain)
    }
    
    private var titleView: some View {
        Text(model.title)
            .typography(.detailBookM)
            .foregroundColor(model.variant.textForegroundColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.trailing, .space4xl)
    }
    
    private var messageView: some View {
        Text(model.message)
            .typography(.detailRegularS)
            .foregroundColor(model.variant.textForegroundColor)
            .padding(.bottom, .spaceXs)
    }
    
    @ViewBuilder
    private var callToActionView: some View {
        if let title = actions.callToAction?.title,
           let action = actions.callToAction?.action {
            secondaryButton(
                title: title,
                action: action
            )
        }
    }
    
    @ViewBuilder
    private var closeButton: some View {
        if let onClose = actions.onClose {
            CloseButton(
                action: onClose,
                primaryLayerColor: model.variant.closeButtonColor,
                secondaryLayerColor: model.variant.closeButtonBackgroundColor
            )
            .padding(.spaceXs)
            .offset(y: -(.space3xs))
        }
    }
    
    private var cardShape: some Shape {
        RoundedRectangle(
            cornerRadius: 16,
            style: .continuous
        )
    }
    
    private var cardBorder: some View {
        cardShape
            .stroke(model.variant.borderColor, lineWidth: 1)
    }
    
    private func secondaryButton(
        title: String,
        action: @escaping (() -> Void)
    ) -> some View {
        GreenButton(
            title: title,
            kind: .secondary,
            size: .small,
            action: action
        )
    }
}

// MARK: - Close Button

private struct CloseButton: View {
    let action: () -> Void
    let primaryLayerColor: Color
    let secondaryLayerColor: Color

    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.palette)
                .typography(.detailRegularM)
                .foregroundStyle(primaryLayerColor, secondaryLayerColor)
                .frame(width: 24, height: 24)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private extension View {
    @ViewBuilder
    func onTapIfAvailable(_ action: (() -> Void)?) -> some View {
        if let action {
            self.onTapGesture(perform: action)
        } else {
            self
        }
    }
}

// MARK: - Previews

#Preview("InfoCard - Information") {
    VStack(spacing: 16) {
        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .information
            ),
            actions: .init(onClose: {})
        )

        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .information
            ),
            actions: .init(
                onClose: {},
                callToAction: .init(title: "Spärra kort", action: {})
            )
        )

        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .information
            ),
            actions: .init(onTap: {})
        )
    }
    .padding()
}

#Preview("InfoCard - InformationHd") {
    VStack(spacing: 16) {
        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .informationHd
            ),
            actions: .init(onClose: {})
        )

        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .informationHd
            ),
            actions: .init(
                onClose: {},
                callToAction: .init(title: "Spärra kort", action: {})
            )
        )

        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .informationHd
            ),
            actions: .init(onTap: {})
        )
    }
    .padding()
}
