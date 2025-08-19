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
    case footnote
    case caption1
    case caption2
    case caption2Emphasized
}

extension Typography {
  /// Base (Large) sizes from Apple’s table
  var size: CGFloat {
    switch self {
    case .largeTitle:           34
    case .title1:               28
    case .title2:               22
    case .title3:               20
    case .headline:             17
    case .headlineEmphasized:   17
    case .body:                 17
    case .callout:              16
    case .subhead:              15
    case .footnote:             13
    case .caption1:             12
    case .caption2:             11
    case .caption2Emphasized:    11
    }
  }

  /// Base (Large) leading from Apple’s table
  var leading: CGFloat {
    switch self {
    case .largeTitle:           41
    case .title1:               34
    case .title2:               28
    case .title3:               25
    case .headline:             22
    case .headlineEmphasized:   22
    case .body:                 22
    case .callout:              21
    case .subhead:              20
    case .footnote:             18
    case .caption1:             16
    case .caption2:             13
    case .caption2Emphasized:    13
    }
  }

  /// Map to a TextStyle so UIFontMetrics can scale with Dynamic Type.
  var textStyle: UIFont.TextStyle {
    switch self {
    case .largeTitle:           .largeTitle
    case .title1:               .title1
    case .title2:               .title2
    case .title3:               .title3
    case .headline:             .headline
    case .headlineEmphasized:   .headline
    case .body:                 .body
    case .callout:              .callout
    case .subhead:              .subheadline
    case .footnote:             .footnote
    case .caption1:             .caption1
    case .caption2:             .caption2
    case .caption2Emphasized:    .caption2
    }
  }

  var weight: Typography.Weight {
    switch self {
    case .title2, .title3, .headlineEmphasized, .caption2Emphasized:
            return .book
    case .largeTitle, .title1, .headline, .body, .callout, .subhead, .footnote, .caption1, .caption2:
            return .regular
    }
  }
}


