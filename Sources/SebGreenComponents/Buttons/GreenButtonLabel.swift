//
//  GreenButtonLabel.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-28.
//

import SwiftUI

struct GreenButtonLabel: View {
    let title: String?
    let icon: Image?
    let iconPosition: GreenButton.IconPosition
    let size: GreenButton.Size
    
    @ScaledMetric(relativeTo: .body) private var iconXL: CGFloat = 24
    @ScaledMetric(relativeTo: .body) private var iconL: CGFloat = 24
    @ScaledMetric(relativeTo: .body) private var iconM: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var iconS: CGFloat = 16
    
    var iconSize: CGFloat {
        switch size {
        case .xLarge: return iconXL
        case .large: return iconL
        case .medium: return iconM
        case .small: return iconS
        }
    }
    
    var spacing: CGFloat { switch size { case .xLarge: return 12; case .large: return 10; case .medium: return 8; case .small: return 6 } }
    
    var body: some View {
        HStack(spacing: spacing) {
            if icon != nil && iconPosition == .leading {
                iconView
            }
            
            if let title {
                Text(title)
                    .typography(GreenButtonTokens.typography(for: size))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading) // left aligned when it wraps
            }
            
            if icon != nil && iconPosition == .trailing {
                iconView
            }
        }
        .frame(maxWidth: .infinity, alignment: .center) // center the stack horizontally
    }
    
    private var iconView: some View {
        icon!
            .resizable()
            .scaledToFit()
            .frame(width: iconSize, height: iconSize)
            .accessibility(hidden: title != nil) // for icon-only we’ll expose label on Button
    }
}
