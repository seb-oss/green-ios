import GdsDimensions
import GdsKit
import SwiftUI

/// A view that is primarily an `HStack` until the user uses a dynamic type font size which is considered
/// an accessibility font, then it becomes a `VStack`.
public struct AdaptiveStack<Content>: View where Content: View {

    @Environment(\.dynamicTypeSize.isAccessibilitySize) var isAccessibilitySize

    public let spacing: CGFloat
    public let horizontalAlignment: HorizontalAlignment
    public let verticalAlignment: VerticalAlignment

    @ViewBuilder public let content: Content

    public init(
        spacing: CGFloat = .gds(.spaceM),
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.content = content()
    }

    public var body: some View {
        if isAccessibilitySize {
            VStack(
                alignment: horizontalAlignment,
                spacing: spacing
            ) {
                content
            }
        } else {
            HStack(
                alignment: verticalAlignment,
                spacing: spacing
            ) {
                content
            }
        }
    }
}

#Preview {
    AdaptiveStack(horizontalAlignment: .leading) {
        Icon(systemName: "globe")
        Text("Hello World")
    }
}
