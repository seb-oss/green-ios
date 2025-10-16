//
//  PrimaryButton.swift
//  SebGreenComponents
//
import SwiftUI
import GdsKit

public struct SebGreenButton: View {
    
    var titleKey: LocalizedStringKey?
    var image: Image?
    let action: (() -> Void)

    @State private var isPressed: Bool = false

    @ScaledMetric private var verticalPadding: CGFloat = .spaceS
    @ScaledMetric private var horizontalPaddingForText: CGFloat = .spaceL
    @ScaledMetric private var horizontalPaddingForImage: CGFloat = .spaceS
    private var horizontalComponentSpacing: CGFloat = .spaceS

    private var horizontalPadding: CGFloat {
        hasText ? horizontalPaddingForText : horizontalPaddingForImage
    }

    private var hasText: Bool {
        titleKey != nil
    }

    public init(
        _ titleKey: LocalizedStringKey,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        if let systemImage {
            self.image = Image(systemName: systemImage)
        }
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: horizontalComponentSpacing) {
                if let image {
                    image
                }
                if let titleKey {
                    Text(titleKey)
                        .typography(.detailBookM)
                }
            }
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
    }
}

public extension SebGreenButton {

    init(
        titleKey: LocalizedStringKey,
        image: Image?,
        action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        self.image = image
        self.action = action
    }

    init(
        systemImage: String,
        action: @escaping () -> Void
    ) {
        self.titleKey = nil
        self.image = Image(systemName: systemImage)
        self.action = action
    }

    init(
        image: Image,
        action: @escaping () -> Void
    ) {
        self.titleKey = nil
        self.image = image
        self.action = action
    }
}

#if DEBUG
#Preview {
    ScrollView {
        VStack {
            SebGreenButton("Primary") {}
                .greenButtonStyle(.primary)
            SebGreenButton("Primary Image", systemImage: "checkmark") {}
                .greenButtonStyle(.primary)
            SebGreenButton("Primary\nMultiline", systemImage: "checkmark") {}
                .greenButtonStyle(.primary)
            SebGreenButton(systemImage: "checkmark") {}
                .greenButtonStyle(.primary)

            SebGreenButton("Secondary") {}
                .greenButtonStyle(.secondary)
            SebGreenButton("Secondary Image", systemImage: "checkmark") {}
                .greenButtonStyle(.secondary)
            SebGreenButton("Secondary\nMultiline", systemImage: "checkmark") {}
                .greenButtonStyle(.secondary)
            SebGreenButton(systemImage: "checkmark") {}
                .greenButtonStyle(.secondary)

            SebGreenButton("Tertiary") {}
                .greenButtonStyle(.tertiary)
            SebGreenButton("Tertiary Image", systemImage: "checkmark") {}
                .greenButtonStyle(.tertiary)
            SebGreenButton("Tertiary\nMultiline", systemImage: "checkmark") {}
                .greenButtonStyle(.tertiary)
            SebGreenButton(systemImage: "checkmark") {}
                .greenButtonStyle(.tertiary)
        }
        .previewByRegisteringFonts()
    }
}
#endif
