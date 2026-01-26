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
    func testFloatingLabelInput_Default() {
        let view = FloatingLabelInput(
            text: .constant(""),
            placeholder: "Label",
            isValid: true
        )
        let hostingController = UIHostingController(rootView: view.frame(width: 300, height: 80))
        assertSnapshot(of: hostingController, as: .image)
    }

    func testFloatingLabelInput_Filled() {
        let view = FloatingLabelInput(
            text: .constant("Hello, world!"),
            placeholder: "Label",
            isValid: true
        )
        let hostingController = UIHostingController(rootView: view.frame(width: 300, height: 80))
        assertSnapshot(of: hostingController, as: .image)
    }

    func testFloatingLabelInput_Error() {
        let view = FloatingLabelInput(
            text: .constant("Error"),
            placeholder: "Label",
            errorText: "Required field",
            isValid: false
        )
        let hostingController = UIHostingController(rootView: view.frame(width: 300, height: 80))
        assertSnapshot(of: hostingController, as: .image)
    }
}

