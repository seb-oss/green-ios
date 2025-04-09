//
//  Font+Typography.swift
//  SebGreen
//
import SwiftUI

public extension Font {

    static func sebGreen(_ size: CGFloat, weight: Typography.Weight) -> Font {
        .custom(weight.fontName, size: size)
    }
}

