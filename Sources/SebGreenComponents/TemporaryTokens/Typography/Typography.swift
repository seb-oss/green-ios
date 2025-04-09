//
//  Typography.swift
//  SebGreen
//

import Foundation
import UIKit

public class Typography {

    public enum Weight: CaseIterable {
        case light
        case regular
        case book
        case medium
        case bold

        var fontName: String {
            switch self {
            case .light:
                return "SansSerifGDS-Light"
            case .regular:
                return "SansSerifGDS-Regular"
            case .book:
                return "SansSerifGDS-Book"
            case .medium:
                return "SansSerifGDS-Medium"
            case .bold:
                return "SansSerifGDS-Bold"
            }
        }
    }

    public struct Size {
        public let headingXl: CGFloat = 32
        public let headingL: CGFloat = 28
        public let headingM: CGFloat = 24
        public let headingS: CGFloat = 20
        public let headingXs: CGFloat = 16
        public let heading2Xs: CGFloat = 14
        public let heading2Xl: CGFloat = 14
        public let detailM: CGFloat = 16
        public let detailS: CGFloat = 14
        public let detailXs: CGFloat = 12
        public let bodyL: CGFloat = 20
        public let bodyM: CGFloat = 16
        public let bodyS: CGFloat = 14
        public let display2Xl: CGFloat = 82
        public let displayXl: CGFloat = 64
        public let displayL: CGFloat = 48
        public let displayM: CGFloat = 36
        public let displayS: CGFloat = 32
        public let preamble2Xl: CGFloat = 32
        public let preambleXl: CGFloat = 28
        public let preambleL: CGFloat = 24
        public let preambleM: CGFloat = 20
        public let preambleS: CGFloat = 18
        public let preambleXs: CGFloat = 16
    }

    static func registerFonts() {
        for weight in Weight.allCases {
            Typography.registerFont(named: weight.fontName)
        }
    }
}

private extension Typography {

    static func registerFont(named name: String) {
       guard
        let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
        let provider = CGDataProvider(data: asset.data as NSData),
        let font = CGFont(provider),
        CTFontManagerRegisterGraphicsFont(font, nil)
        else {
           let message = "Failed to register font \(name)"
           assertionFailure(message)
           print(message)
           return
       }
    }
}
