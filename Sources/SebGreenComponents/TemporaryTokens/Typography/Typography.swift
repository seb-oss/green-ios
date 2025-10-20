//
//  TypographyStyle.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-18.
//


import SwiftUI
import UIKit

// MARK: - Typography

public enum Typography {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case headlineEmphasized
    case body
    case callout
    case subhead
    case subheadEmphasized
    case footnote
    case caption1
    case caption2
    case caption2Emphasized
}

extension Typography {
  /// Base (Large) sizes from Apple’s table
  var size: CGFloat {
    switch self {
    case .largeTitle:               34
    case .title1:                   28
    case .title2:                   22
    case .title3:                   20
    case .headline:                 17
    case .headlineEmphasized:       17
    case .body:                     17
    case .callout:                  16
    case .subhead:                  15
    case .subheadEmphasized:        15
    case .footnote:                 13
    case .caption1:                 12
    case .caption2:                 11
    case .caption2Emphasized:       11
    }
  }

  /// Map to a TextStyle so UIFontMetrics can scale with Dynamic Type.
  var textStyle: Font.TextStyle {
    switch self {
    case .largeTitle:               .largeTitle
    case .title1:                   .title
    case .title2:                   .title2
    case .title3:                   .title3
    case .headline:                 .headline
    case .headlineEmphasized:       .headline
    case .body:                     .body
    case .callout:                  .callout
    case .subhead:                  .subheadline
    case .subheadEmphasized:        .subheadline
    case .footnote:                 .footnote
    case .caption1:                 .caption
    case .caption2:                 .caption2
    case .caption2Emphasized:       .caption2
    }
  }

  var weight: Typography.Weight {
    switch self {
    case .title2, .title3, .headlineEmphasized, .subheadEmphasized, .caption2Emphasized:
            return .book
    case .largeTitle, .title1, .headline, .body, .callout, .subhead, .footnote, .caption1, .caption2:
            return .regular
    }
  }
}

extension Typography: CaseIterable {}

#if DEBUG
#Preview {
    ScrollView {
        ForEach(Typography.allCases, id: \.self) {
            Text("\($0)")
                .typography($0)
                .padding(.bottom, 4)
        }
        .previewByRegisteringFonts()
    }
}
#endif
