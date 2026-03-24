import GdsKit
import SwiftUI

@available(iOS 16, *)
public struct Showcase: View {
    
    public init() {}
    
    public var body: some View {
        List {
            NavigationLink("Demo Navigation Link") {
                Text("Demo")
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
