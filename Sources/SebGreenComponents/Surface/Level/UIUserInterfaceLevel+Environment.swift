import SwiftUI

public extension EnvironmentValues {
    @Entry private(set) var userInterfaceLevel: UIUserInterfaceLevel = UITraitCollection.current.userInterfaceLevel
}

public extension UIUserInterfaceLevel {
    var isElevated: Bool {
        self == .elevated
    }
}
