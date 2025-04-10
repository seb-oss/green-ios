//
//  Colors+PocCustom.swift
//  SebGreenComponents
//

import UIKit
import SwiftUI

public extension LightModeColors {
    struct PocCustom {
        public static let grey28 =  UIColor(red: 0.039, green: 0.043, blue: 0.039, alpha: 1)
        public static let grey9 = UIColor(red: 0.792, green: 0.808, blue: 0.800, alpha: 1)
        public static let grey6 = UIColor(red: 0.918, green: 0.922, blue: 0.922, alpha: 1)
    }
}

public extension DarkModeColors {
    struct PocCustom {
        public static let grey28 =  UIColor(red: 0.039, green: 0.043, blue: 0.039, alpha: 1)
        public static let grey9 = UIColor(red: 0.792, green: 0.808, blue: 0.800, alpha: 1)
        public static let grey6 = UIColor(red: 0.918, green: 0.922, blue: 0.922, alpha: 1)
    }
}

public extension UIColors {
    struct PocCustom {
        public static var grey28: UIColor {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ?
                    DarkModeColors.PocCustom.grey28 :
                    LightModeColors.PocCustom.grey28
            }
        }

        public static var grey9: UIColor {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ?
                    DarkModeColors.PocCustom.grey9 :
                    LightModeColors.PocCustom.grey9
            }
        }

        public static var grey6: UIColor {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ?
                    DarkModeColors.PocCustom.grey6 :
                    LightModeColors.PocCustom.grey6
            }
        }
    }
}

public extension Colors {
    struct PocCustom {
        public static let grey28 = Color(uiColor: UIColors.PocCustom.grey28)
        public static let grey9 = Color(uiColor: UIColors.PocCustom.grey9)
        public static let grey6 = Color(uiColor: UIColors.PocCustom.grey6)
    }
}

