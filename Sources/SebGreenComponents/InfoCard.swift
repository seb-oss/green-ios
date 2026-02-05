//
//  InfoCard.swift
//  SebGreenComponents
//
//

import SwiftUI

public struct InfoCardView: View {
    public enum Variant {
        case information
        case informationHd
        
        var backgroundColor: Color {
            switch self {
            case .information:
                return Color.l2Neutral02
            case .informationHd:
                return Color.l2NeutralLoud
            }
        }
        
        var borderColor: Color {
            switch self {
            case .information:
                return Color.borderInformation02
            case .informationHd:
                return Color.clear
            }
        }
        
        var closeButtonBackgroundColor: Color {
            switch self {
            case .information:
                return Color.l3Neutral02
            case .informationHd:
                return Color.l3NeutralTone
            }
        }
        
        var closeButtonColor: Color {
            switch self {
            case .information:
                return Color.contentNeutral02
            case .informationHd:
                return Color.contentInversed
            }
        }
        
        var textForegroundColor: Color {
            switch self {
            case .information:
                return Color.contentNeutral01
            case .informationHd:
                return Color.contentInversed
            }
        }
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
        .padding(16)
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
            .padding(.trailing, 56)
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
            secondaryButton(title: title, action: action)
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
            .padding(8)
            .offset(y: -4)
        }
    }
    
    private var cardShape: some Shape {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
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
