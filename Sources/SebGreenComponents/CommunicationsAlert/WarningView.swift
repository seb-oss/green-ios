//
// Copyright © 2026 Skandinaviska Enskilda Banken AB (publ). All rights reserved.
//

import SwiftUI
import GdsKit

struct WarningView: View {
    private let title: String
    private let description: String
    private let accessibilityLabel: String
    private let accessibilityHint: String
    private let buttonAction: InformationMessageView.ButtonInfo?
    @AccessibilityFocusState private var accessibilityFocus

    init(
        title: String,
        description: String,
        accessibilityLabel: String,
        accessibilityHint: String,
        buttonAction: InformationMessageView.ButtonInfo? = nil
    ) {
        self.title = title
        self.description = description
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.buttonAction = buttonAction
    }
    
    private var actionButton: some View {
        VStack {
            if let actionButton = buttonAction {
                Button(
                    action: actionButton.action,
                    label: {
                        Text(actionButton.title)
                            .typography(.heading2xs)
                            .foregroundStyle(Color.stateNotice06)
                    }
                )
                .accessibilityAction {
                    actionButton.action()
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .typography(.headingM)
                .padding(.bottom, 2.0)
            
            Text(description)
                .typography(.heading2xs)
                .padding(.bottom, 4.0)
            
            actionButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 12)
        .padding([.horizontal, .bottom], 18)
        .background(Color.contentWarning02)
        .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
        .accessibilityFocused($accessibilityFocus)
        .onAppear { accessibilityFocus = true }
        .overlay(
            RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(
                    Color.borderWarning02,
                    lineWidth: .cornerRadiusLightWidth
                )
        )
    }
}

#Preview("Warning message without action") {
    WarningView(
        title: "Error message",
        description: "This message is displayed when a error occurs after making an API-call. It's mostly used for network errors where the message cell can be tapped to retry any failed requests.",
        accessibilityLabel: "",
        accessibilityHint: ""
    )
}

#Preview("Warning message with action") {
    WarningView(
        title: "Error message",
        description: "This message is displayed when a error occurs after making an API-call. It's mostly used for network errors where the message cell can be tapped to retry any failed requests.",
        accessibilityLabel: "",
        accessibilityHint: "",
        buttonAction: .init(
            title: "Retry",
            action: { }
        )
    )
}

private extension CGFloat {
    static let cornerRadiusLightWidth = 1.5
    static let cornerRadius = 12.0
}
