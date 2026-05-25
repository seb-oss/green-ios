import GdsKit
import SwiftUI

private enum Component: String, CaseIterable, Identifiable {
    case callouts = "Callout"
    case inputFields = "Input Field"
    case toggles = "Toggle"
	case buttons = "Buttons"

    var id: String { rawValue }

    @ViewBuilder
    var view: some View {
        switch self {
        case .callouts: CalloutDemo()
        case .inputFields: InputFieldDemo()
        case .toggles: ToggleDemo()
		case .buttons: SEBGreenButtonStyleDemo()
        }
    }
}

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
        .background(.gds(.l1Neutral02))
        .navigationTitle("Green Components")
    }
}

#Preview {
    NavigationStack {
        Showcase()
    }
}
