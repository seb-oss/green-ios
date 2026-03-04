import GdsKit
import SwiftUI

struct DemoContainer<Configuration: View, Content: View>: View {
    private let title: String
    private let configuration: Configuration
    private let content: Content
    private let storageKey: String
    
    @Environment(\.level) private var level
    
    @AppStorage private var shouldShowConfigurationView: Bool
    
    init(
        _ title: String,
        @ViewBuilder configuration: () -> Configuration,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.configuration = configuration()
        self.content = content()
        
        let storageKey = title.lowercased().filter { $0.isLetter || $0.isNumber }
        self.storageKey = storageKey
        self._shouldShowConfigurationView = AppStorage(
            wrappedValue: true,
            "shouldShowConfigurationView_\(storageKey)"
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: .spaceXl) {
                if shouldShowConfigurationView {
                    configuration
                }
                
                content
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .animation(.easeIn, value: shouldShowConfigurationView)
        .background(level.colors.neutral02)
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { withAnimation { shouldShowConfigurationView.toggle() } }) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}
