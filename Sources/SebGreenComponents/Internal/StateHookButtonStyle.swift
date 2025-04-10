//
//  ButtonStateHookStyle.swift
//  SebGreenComponents
//

import SwiftUI

struct StateHookButtonStyle: ButtonStyle {

    var onPressedChanged: (Bool) -> Void

    // Wrapper for isPressed where we can run custom logic via didSet (or willSet)
    @State private var isPressedWrapper: Bool = false {
        didSet {
            onPressedChanged(isPressedWrapper)
        }
    }

    // return the label unaltered, but add a hook to watch changes in configuration.isPressed
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed, perform: { newValue in isPressedWrapper = newValue })
    }
}
