import SwiftUI

public struct InputFieldStyle {
    let variant: Variant
    let background: Configuration.Background

    public init(
        variant: Variant = .default,
        background: Configuration.Background = .white
    ) {
        self.variant = variant
        self.background = background
    }

    public enum Variant {
        case `default`, floating
    }
}
