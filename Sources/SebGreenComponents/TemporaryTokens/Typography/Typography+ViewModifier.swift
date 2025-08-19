//
//  Typography+ViewModifier.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-18.
//

import SwiftUI

// MARK: - Modifier function

public extension View {
  /// Apply SEB font + the correct Apple leading for a given text style.
  func typography(_ style: Typography) -> some View {
    modifier(style)
  }
}

// MARK: - ViewModifier that enforces leading (line height)

extension Typography: ViewModifier {
    public func body(content: Content) -> some View {
        // 1) Scale size & leading for the current Dynamic Type category.
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledSize = metrics.scaledValue(for: size)
        let scaledLeading = metrics.scaledValue(for: leading)

        // 2) Build UIFont to know its natural lineHeight at the scaled size.
        //    (Replace `weight.fontName` with however you resolve the actual font name.)
        let uiFont = UIFont(name: weight.fontName, size: scaledSize) ?? .systemFont(ofSize: scaledSize)
        let naturalLineHeight = uiFont.lineHeight

        // 3) Extra spacing needed so that baseline-to-baseline = Apple's leading.
        //    If a font’s natural line height already exceeds the target, don’t go negative.
        let extraLineSpacing = max(0, scaledLeading - naturalLineHeight)

        return content
          .font(.custom(weight.fontName, size: scaledSize))
          .lineSpacing(extraLineSpacing)
          //TODO: Ensure Dynamic Type scales custom font properly in UIKit-embedded views
          //.environment(\.sizeCategory, .unspecified) // keep SwiftUI default behavior
    }
}
