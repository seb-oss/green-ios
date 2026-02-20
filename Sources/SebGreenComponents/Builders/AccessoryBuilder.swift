import SwiftUI

@resultBuilder
public struct AccessoryBuilder {
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }

    static func buildBlock(_ component: InfoButton) -> some View {
        component
    }
}
