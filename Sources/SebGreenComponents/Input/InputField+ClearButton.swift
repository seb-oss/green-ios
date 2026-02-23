import SwiftUI

extension InputField {
    // TODO: Hide this view from accessibility and present it as a custom action
    struct ClearButton: View {
        @Binding var text: String

        var body: some View {
            Button {
                withAnimation {
                    text = String()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.contentNeutral02)
            }
        }
    }
}
