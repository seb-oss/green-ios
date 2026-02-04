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
                return Color.l2Neutral03 // TODO: Color Token missing
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
    }
    
    // MARK: - Model
    public struct Model: Equatable {
        public var title: String
        public var message: String
        public var ctaTitle: String?
        public var variant: Variant
        
        public init(
            title: String,
            message: String,
            ctaTitle: String? = nil,
            variant: Variant
        ) {
            self.title = title
            self.message = message
            self.ctaTitle = ctaTitle
            self.variant = variant
        }
    }
    
    // MARK: - Actions
    public struct Actions {
        public var onClose: (() -> Void)?
        public var cta: (() -> Void)?
        public var onTap: (() -> Void)?
        
        public init(
            onClose: (() -> Void)? = nil,
            onTap: (() -> Void)? = nil,
            cta: (() -> Void)? = nil
        ) {
            self.onClose = onClose
            self.cta = cta
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
        VStack(alignment: .leading, spacing: .space3xs) {
            header
            
            Text(model.message)
                .typography(.detailRegularS)
                .padding(.bottom, .spaceXs)
            
            if let ctaTitle = model.ctaTitle,
               let ctaAction = actions.cta {
                primaryButton(
                    title: ctaTitle,
                    action: ctaAction
                )
            }
        }
        .padding(12)
        .background(model.variant.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
        )
        .accessibilityElement(children: .contain)
    }
    
    // MARK: - Subviews
    
    private var header: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(model.title)
                .typography(.headingXs)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 8)
            
            if let onClose = actions.onClose {
                CloseButton(action: onClose)
            }
        }
    }
    
    private func primaryButton(
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
    
    private var borderColor: Color {
        Color.borderInformation02
    }
}

// MARK: - Close Button

private struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .typography(.detailRegularM)
                .foregroundStyle(Color.contentNeutral02)
                .frame(width: 24, height: 24)
            
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Close"))
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
                ctaTitle: "Spärra kort",
                variant: .information
            ),
            actions: .init(onClose: {}, cta: {})
        )
        
        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .information
            ),
            actions: .init()
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
                ctaTitle: "Spärra kort",
                variant: .informationHd
            ),
            actions: .init(onClose: {}, cta: {})
        )
        
        InfoCardView(
            model: .init(
                title: "Spärra ditt kort snabbt i appen",
                message: "Välj kontot som kortet är kopplat till och sen Hantera kort.",
                variant: .informationHd
            ),
            actions: .init()
        )
        
    }
    .padding()
}
