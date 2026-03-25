import SwiftUI
import XCTest

@testable import SebGreenComponents

@available(iOS 16, *)
extension View {
    fileprivate func inputFieldSnapshotTest(
        _ suffix: String? = nil,
        surface: Surface = .neutral02,
        function: String = #function
    ) {
        let baseName = function.replacing("()", with: "")
        let name = [baseName, suffix]
            .compactMap(\.self)
            .joined(separator: "_")

        self
            .inputFieldStyle(.default)
            .snapshotTest(surface, testName: "\(name)_default")

        self
            .inputFieldStyle(.floating)
            .snapshotTest(surface, testName: "\(name)_floating")
    }
}

@available(iOS 16, *)
final class InputFieldSnapshotTests: SEBViewImageSnapshotTesting {

    func test_inputField() {
        InputField("Label", text: .constant(""))
            .inputFieldSnapshotTest()

        InputField("Label", text: .constant("Text"))
            .inputFieldSnapshotTest("filled")
    }

    func test_inputField_optional() {
        InputField("Label", text: .constant("Text"))
            .optionalField()
            .inputFieldSnapshotTest()
    }

    func test_inputField_supportive_text() {
        InputField("Label", text: .constant(""))
            .supportiveText("Support text")
            .snapshotTest(.neutral02)
    }

    func test_inputField_info_button() {
        // Info button is only available in default style
        InputField("Label", text: .constant("")) {
            Button {
            } label: {
                Image(systemName: "info.circle")
            }
        }
        .snapshotTest(.neutral02)
    }

    func test_inputField_expanded_textArea() {
        InputField("Label", text: .constant(""))
            .expandTextArea()
            .inputFieldSnapshotTest()
    }

    func test_inputField_alternative_background() {
        InputField("Label", text: .constant(""))
            .inputFieldSnapshotTest(surface: .neutral01)

        InputField("Label", text: .constant("Text"))
            .inputFieldSnapshotTest(surface: .neutral01)
    }

    func test_inputField_error() {
        InputField("Label", text: .constant("Text"))
            .validation(ValidationError("Error text"))
            .inputFieldSnapshotTest()

        InputField("Label", text: .constant("Text"))
            .validation(
                ValidationError("The value entered is not valid. Please check and try again.")
            )
            .inputFieldSnapshotTest("multiline")
    }

    func test_inputField_focused() {
        InputField("Label", text: .constant("Text"))
            .applyRules(to: .constant("Text"), rules: .maxCharacters(50))
            .overrideFocusVisibility()
            .inputFieldSnapshotTest()

        let loremIpsum = """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
            """

        InputField("Label", text: .constant(loremIpsum))
            .applyRules(to: .constant(loremIpsum), rules: .maxCharacters(250))
            .overrideFocusVisibility()
            .inputFieldSnapshotTest("multiline")
    }
}
