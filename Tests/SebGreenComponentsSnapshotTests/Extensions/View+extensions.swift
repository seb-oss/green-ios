import SebGreenComponents
import SwiftUI
import SnapshotTesting

extension View {
    func snapshotTest(
        _ surface: Surface = .neutral02,
        level: Level = .level1,
        fileID: StaticString = #fileID,
        file filePath: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let view = self
            .frame(width: 320)
            .padding(.spaceM)
            .surface(surface, level: level)
            
        snapshot(of: view.colorScheme(.dark), fileID: fileID, file: filePath, testName: "\(testName)_dark", line: line, column: column)
        snapshot(of: view.colorScheme(.light), fileID: fileID, file: filePath, testName: testName, line: line, column: column)
    }
    
    private func snapshot<Content: View>(
        of content: Content,
        fileID: StaticString,
        file filePath: StaticString,
        testName: String,
        line: UInt,
        column: UInt
    ) {
        assertSnapshot(
            of: content,
            as: .image(),
            record: SEBViewImageSnapshotTesting.snapshotRecordMode,
            fileID: fileID,
            file: filePath,
            testName: testName,
            line: line,
            column: column
        )
    }
}
