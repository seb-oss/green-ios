//
//  LabelOutsideInputSnapshotTests.swift
//  SebGreenComponents
//
//  Created by Snapshot Bot on 2026-01-26.
//

import SwiftUI
import XCTest
import SnapshotTesting
@testable import SebGreenComponents

final class LabelOutsideInputSnapshotTests: SEBViewImageSnapshotTesting {
    private static let recordSnapshots = false
    
    func testLabelOutsideInput_Default() {
        let view = LabelOutsideInput(
            text: .constant(""),
            title: "Title",
            placeholder: "Label"
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.recordSnapshots)
    }

    func testLabelOutsideInput_Filled() {
        let view = LabelOutsideInput(
            text: .constant("Hello, world!"),
            title: "Title",
            placeholder: "Label"
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.recordSnapshots)
    }

    func testLabelOutsideInput_Error() {
        let view = LabelOutsideInput(
            text: .constant("Error"),
            title: "Title",
            placeholder: "Label",
            errorText: "Required field",
            isValid: false
        )
        .frame(width: 320)
        .padding(.spaceM)
        .background(Color.l2Elevated01)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: Self.recordSnapshots)
    }
}

