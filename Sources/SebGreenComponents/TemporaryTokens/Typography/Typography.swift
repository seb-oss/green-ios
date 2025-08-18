//
//  Typography.swift
//  SebGreen
//

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
                return "SEBSansSerifGDS-Light"
            case .regular:
                return "SEBSansSerifGDS-Regular"
            case .book:
                return "SEBSansSerifGDS-Book"
            case .medium:
                return "SEBSansSerifGDS-Medium"
            case .bold:
                return "SEBSansSerifGDS-Bold"
            }
        }
    }
}
