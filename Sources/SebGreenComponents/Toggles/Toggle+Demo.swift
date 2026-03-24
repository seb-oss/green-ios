import SwiftUI

@available(iOS 16, *)
struct ToggleDemo: View {
    @State private var toggleOn = true
    @State private var toggleOff = false

    var body: some View {
        DemoContainer("Toggles") {
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Enabled toggle (on)", isOn: $toggleOn)
                    .toggleStyle(.gds)

                Toggle("Enabled toggle (off)", isOn: $toggleOff)
                    .toggleStyle(.gds)

                Toggle("Disabled toggle (on)", isOn: $toggleOn)
                    .toggleStyle(.gds)
                    .disabled(true)

                Toggle("Disabled toggle (off)", isOn: $toggleOff)
                    .toggleStyle(.gds)
                    .disabled(true)
            }
        }
    }
}

@available(iOS 16, *)
#Preview {
    ToggleDemo()
}
