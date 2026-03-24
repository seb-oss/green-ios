import GdsKit
import SwiftUI

private enum Component: String, CaseIterable, Identifiable {
    case inputFields = "Input Field"
    case toggles = "Toggle"

    var id: String { rawValue }

    @available(iOS 16, *)
    @ViewBuilder
    var view: some View {
        switch self {
        case .inputFields: InputFieldDemo()
        case .toggles: ToggleDemo()
        }
    }
}

@available(iOS 16, *)
public struct Showcase: View {
    private let components = Component.allCases

    public init() {}

    public var body: some View {
        List {
            Section("Components") {
                ForEach(components) { component in
                    NavigationLink(component.rawValue) {
                        component.view
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.l1Neutral02)
        .navigationTitle("Green Components")
    }
}

@available(iOS 16, *)
#Preview {
    NavigationStack {
        Showcase()
    }
}
