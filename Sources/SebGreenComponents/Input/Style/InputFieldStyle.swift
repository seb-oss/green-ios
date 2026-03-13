import SwiftUI

public struct InputFieldStyle {
    let variant: Variant

    public init(variant: Variant = .default) {
        self.variant = variant
    }

    public enum Variant {
        case `default`, floating
    }
}
