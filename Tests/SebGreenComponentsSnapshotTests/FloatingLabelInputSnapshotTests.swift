//
//  FloatingLabelInputSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2026-01-26.
//


import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class FloatingLabelInputSnapshotTests: XCTestCase {
    override class func setUp() {
        isRecording = true
    }
    
    func testFloatingLabelInput_Default() {
        let view = FloatingLabelInput(
            text: .constant(""),
            placeholder: "Label",
            isValid: true
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func testFloatingLabelInput_Filled() {
        let view = FloatingLabelInput(
            text: .constant("Hello, world!"),
            placeholder: "Label",
            isValid: true
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }

    func testFloatingLabelInput_Error() {
        let view = FloatingLabelInput(
            text: .constant("Error"),
            placeholder: "Label",
            errorText: "Required field",
            isValid: false
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }
}

