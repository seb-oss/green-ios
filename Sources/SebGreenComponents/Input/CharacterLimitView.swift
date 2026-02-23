import SwiftUI

struct CharacterLimitView: View {
    let characterCount: Int
    let maxLimit: Int

    var body: some View {
        Text("\(characterCount)/\(maxLimit)")
            .typography(.detailRegularXs)
            .foregroundStyle(Color.contentNeutral01)
            .accessibilityLabel("\(characterCount) of \(maxLimit)")
            // No animation wanted
            .animation(nil, value: characterCount)
    }
}

#Preview {
    VStack {
        CharacterLimitView(characterCount: 0, maxLimit: 50)
        CharacterLimitView(characterCount: 45, maxLimit: 50)
        CharacterLimitView(characterCount: 50, maxLimit: 50)
    }
}
