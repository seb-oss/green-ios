import GdsKit
import SwiftUI

@available(iOS 16, *)
struct DemoSection<Content: View>: View {
    private let title: String
    private let content: Content

    init(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        Section {
            VStack(spacing: .space3xs) {
                content
            }
        } header: {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .bold()
        }
    }
}

@available(iOS 16, *)
struct DemoContainer<Configuration: View, Content: View>: View {
    private let title: String
    private let contentPadding: CGFloat
    private let configuration: Configuration
    private let content: Content
    private let storageKey: String

    @Environment(\.level) private var level

    @AppStorage private var shouldShowConfigurationView: Bool
    
    private var isConfigurable: Bool {
        Configuration.self != EmptyView.self
    }

    init(
        _ title: String,
        contentPadding: CGFloat = .spaceM,
        @ViewBuilder configuration: () -> Configuration,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.contentPadding = contentPadding
        self.configuration = configuration()
        self.content = content()

        let storageKey = title.lowercased().filter {
            $0.isLetter || $0.isNumber
        }
        self.storageKey = storageKey
        self._shouldShowConfigurationView = AppStorage(
            wrappedValue: true,
            "shouldShowConfigurationView_\(storageKey)"
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .spaceXl) {
                if isConfigurable && shouldShowConfigurationView {
                    configuration
                        .background(in: .rect(cornerRadius: 16))
                        .padding(.spaceM)
                }

                content
            }
            .frame(maxWidth: .infinity)
            .padding(contentPadding)
        }
        .animation(.easeIn, value: shouldShowConfigurationView)
        .background(level.colors.neutral02)
        .navigationTitle(title)
        .toolbar {
            if isConfigurable {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            shouldShowConfigurationView.toggle()
                        }
                    } label: {
                        Image(systemName: "gear")
                    }
                    
                }
            }
        }
    }
}

@available(iOS 16, *)
extension DemoContainer where Configuration == EmptyView {
    init(
        _ title: String,
        contentPadding: CGFloat = .spaceM,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.contentPadding = contentPadding
        self.configuration = EmptyView()
        self.content = content()

        let storageKey = title.lowercased().filter {
            $0.isLetter || $0.isNumber
        }
        self.storageKey = storageKey
        self._shouldShowConfigurationView = AppStorage(
            wrappedValue: false,
            "shouldShowConfigurationView_\(storageKey)"
        )
    }
}
