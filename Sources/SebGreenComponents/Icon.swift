import GdsKit
import SwiftUI

/// A view that displays an image or SF Symbol icon.
///
/// `Icon` scales automatically with the system's Dynamic Type size settings,
/// capped at the specified `dynamicTypeSizeRange` upper bound.
///
/// ```swift
/// // System symbol with default scaling
/// Icon(systemName: "star.fill")
///
/// // Custom upper bound — allow scaling up to .xxLarge only
/// Icon(systemName: "star.fill", dynamicTypeSizeRange: ..<.xxLarge)
/// ```
public struct Icon: View {
    private enum ImageSource {
        case resource(ImageResource)
        case system(String)
    }

    private let imageSource: ImageSource
    /// The range of Dynamic Type sizes the icon is allowed to scale within.
    ///
    /// The icon scales automatically up to, but not including, the specified upper bound.
    /// Defaults to `..<DynamicTypeSize.accessibility1`.
    let dynamicTypeSizeRange: PartialRangeUpTo<DynamicTypeSize>

    init(
        _ resource: ImageResource,
        dynamicTypeSizeRange: PartialRangeUpTo<DynamicTypeSize> = ..<DynamicTypeSize.accessibility1
    ) {
        self.imageSource = .resource(resource)
        self.dynamicTypeSizeRange = dynamicTypeSizeRange
    }

    public init(
        systemName: String,
        dynamicTypeSizeRange: PartialRangeUpTo<DynamicTypeSize> = ..<DynamicTypeSize.accessibility1
    ) {
        self.imageSource = .system(systemName)
        self.dynamicTypeSizeRange = dynamicTypeSizeRange
    }

    public var body: some View {
        Group {
            switch imageSource {
            case .resource(let resource):
                Image(resource)
            case .system(let name):
                Image(systemName: name)
            }
        }
        .dynamicTypeSize(dynamicTypeSizeRange)
    }
}
