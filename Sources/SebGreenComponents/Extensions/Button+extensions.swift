import SwiftUI

extension Button where Label == Icon {
    /// Creates a button with an `Icon` as its label.
    ///
    /// - Parameters:
    ///   - systemName: The SF Symbol name for the icon.
    ///   - dynamicTypeSizeRange: The Dynamic Type size range the icon scales within. Defaults to `..<DynamicTypeSize.accessibility1`.
    ///   - action: The action to perform when the button is triggered.
    public init(
        systemName: String,
        dynamicTypeSizeRange: PartialRangeUpTo<DynamicTypeSize> = ..<DynamicTypeSize.accessibility1,
        action: @escaping () -> Void
    ) {
        self.init(action: action) {
            Icon(systemName: systemName, dynamicTypeSizeRange: dynamicTypeSizeRange)
        }
    }
}
