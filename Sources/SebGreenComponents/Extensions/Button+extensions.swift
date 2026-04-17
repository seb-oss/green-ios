import SwiftUI

extension Button where Label == Icon<PartialRangeUpTo<DynamicTypeSize>> {
    /// Creates a button with an SF Symbol ``Icon`` as its label, using the default dynamic type scaling range.
    ///
    /// The icon scales with Dynamic Type up to (but not including) `accessibility1`.
    ///
    /// - Parameters:
    ///   - systemName: The name of the SF Symbol to display.
    ///   - dynamicTypeSizeRange: The range of Dynamic Type sizes the icon scales within.
    ///     Defaults to `..<DynamicTypeSize.accessibility1`.
    ///   - action: The action to perform when the button is tapped.
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

extension Button {
    /// Creates a button with an SF Symbol ``Icon`` as its label, using a custom dynamic type scaling range.
    ///
    /// Use this initializer when you need a range type other than the default `PartialRangeUpTo`,
    /// for example a closed range to pin the icon between two sizes:
    /// ```swift
    /// Button(systemName: "bell", dynamicTypeSizeRange: .medium...(.xxxLarge)) {
    ///     // handle tap
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - systemName: The name of the SF Symbol to display.
    ///   - dynamicTypeSizeRange: A range expression constraining how the icon scales with Dynamic Type.
    ///   - action: The action to perform when the button is tapped.
    public init<R: RangeExpression>(
        systemName: String,
        dynamicTypeSizeRange: R,
        action: @escaping () -> Void
    ) where Label == Icon<R>, R.Bound == DynamicTypeSize {
        self.init(action: action) {
            Icon(systemName: systemName, dynamicTypeSizeRange: dynamicTypeSizeRange)
        }
    }
}
