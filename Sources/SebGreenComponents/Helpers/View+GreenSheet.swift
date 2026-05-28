import GdsKit
import SwiftUI

private struct GreenSheetNavigationStack<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        NavigationStack {
            ScrollView(content: content)
                .navigationBarTitleDisplayMode(.inline)
                .scrollBasedOnSizeIfAvailable()
        }
        .scrollIndicators(.hidden)
    }
}

extension View {
    public func greenSheet(
        isPresented: Binding<Bool>,
        surface: Surface = .neutral02,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        sheet(isPresented: isPresented) {
            if #available(iOS 16.4, *) {
                GreenSheetNavigationStack(content: content)
                    .presentationSurface(surface)
            } else {
                GreenSheetNavigationStack(content: content)
                    .surface(surface, level: .level2)
            }
        }
    }

    public func greenSheet<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        surface: Surface = .neutral02,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        sheet(item: item) { itemValue in
            if #available(iOS 16.4, *) {
                GreenSheetNavigationStack {
                    content(itemValue)
                }
                .presentationSurface(surface)
            } else {
                GreenSheetNavigationStack {
                    content(itemValue)
                }
                .surface(surface, level: .level2)
            }
        }
    }

    public func sheetTitle(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        typography: Typography = .headingXs
    ) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                Text(
                    key,
                    tableName: tableName,
                    bundle: bundle,
                    comment: comment
                )
                .font(.gds(typography))
            }
        }
    }

    public func sheetTitle(
        _ content: some StringProtocol,
        typography: Typography = .headingXs
    ) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                Text(content)
                    .font(.gds(typography))
                    .accessibilityAddTraits(.isHeader)
            }
        }
    }

    @ViewBuilder
    fileprivate func scrollBasedOnSizeIfAvailable() -> some View {
        if #available(iOS 16.4, *) {
            self
                .scrollBounceBehavior(.basedOnSize)
        } else {
            self
        }
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var present = false

    Button("Present simple sheet") {
        present = true
    }
    .greenSheet(isPresented: $present, surface: .neutral01) {
        Text(
            """
            What is Lorem Ipsum?

            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

            Why do we use it?

            It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).

            Where does it come from?

            Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
            """
        )
        .padding(.horizontal)
        .sheetTitle("Amazing title", typography: .headingS)
        .navigationCloseButton {
            present = false
        }
        .presentationDetents([.medium, .large])
    }
}
