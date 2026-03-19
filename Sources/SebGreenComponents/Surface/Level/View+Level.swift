import SwiftUI

public extension View {
    func level(_ level: Level) -> some View {
        environment(\.level, level)
    }
}
