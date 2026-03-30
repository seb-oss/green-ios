//
// Copyright © 2026 Skandinaviska Enskilda Banken AB (publ). All rights reserved.
//

import SwiftUI

public struct InformationMessageView: View {
    public enum MessageType {
        case warning
        case information
    }
    
    public struct ButtonInfo {
        let title: String
        let action: () -> Void

        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
    }
    
    public struct Information {
        let title: String
        let description: String
        let accessibilityLabel: String
        let accessibilityHint: String

        let buttonAction: ButtonInfo?
        
        public init(
            title: String,
            description: String,
            accessibilityLabel: String,
            accessibilityHint: String,
            buttonAction: ButtonInfo? = nil
        ) {
            self.title = title
            self.description = description
            self.accessibilityLabel = accessibilityLabel
            self.accessibilityHint = accessibilityHint

            self.buttonAction = buttonAction
        }
    }
    
    private let type: MessageType
    private let information: Information
    
    public init(type: MessageType, information: Information) {
        self.type = type
        self.information = information
    }
    
    public var body: some View {
        switch type {
        case MessageType.warning:
            WarningView(
                title: information.title,
                description: information.description,
                accessibilityLabel: information.accessibilityLabel,
                accessibilityHint: information.accessibilityHint,
                buttonAction: information.buttonAction
            )

        case MessageType.information:
            InformationView(
                title: information.title,
                description: information.description,
                accessibilityLabel: information.accessibilityLabel,
                accessibilityHint: information.accessibilityHint,
                buttonAction: information.buttonAction
            )
        }
    }
}

#Preview("Information message without action") {
    InformationMessageView(
        type: .information, 
        information: .init(
            title: "Error message",
            description: "This message is displayed when a error occurs after making an API-call.",
            accessibilityLabel: "test",
            accessibilityHint: "test cation"
        )
    )
}

#Preview("Warning message without action") {
    InformationMessageView(
        type: .warning,
        information: .init(
            title: "Error message",
            description: "This message is displayed when a error occurs after making an API-call.",
            accessibilityLabel: "test",
            accessibilityHint: "test cation",
            buttonAction: .init(title: "Try again", action: {})
        )
    )
}

