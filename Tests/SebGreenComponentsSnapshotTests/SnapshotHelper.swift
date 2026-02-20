//
//  SnapshotHelper.swift
//  SebGreenComponents
//
//
import SwiftUI
import SnapshotTesting

enum SnapshotDevice: String, CaseIterable {
    case iPhoneSE3 = "iPhoneSE3"
    case iPhone15Pro = "iPhone15Pro"
    case iPad10th = "iPad10th"

    var config: ViewImageConfig {
        switch self {
        case .iPhoneSE3:
            return .iPhoneSe
        case .iPhone15Pro:
            return .iPhone13Pro
        case .iPad10th:
            return .iPadPro11
        }
    }
}

func assertOnAllDevices<V: View>(
    name: String,
    view: V,
    record: Bool,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    for device in SnapshotDevice.allCases {
        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: device.config),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: device.rawValue,
            record: record,
            file: file,
            testName: "\(testName)_\(name)",
            line: line
        )
    }
}
