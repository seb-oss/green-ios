import GdsKit
import SwiftUI

public struct Icon: View {
    private enum ImageSource {
        case resource(ImageResource)
        case system(String)
    }

    public struct Configuration {
        let defaultSize: CGFloat
        let maxSize: CGFloat?
        let relativeTo: Font.TextStyle
 
        public init(
            defaultSize: CGFloat = 24,
            maxSize: CGFloat? = nil,
            relativeTo: Font.TextStyle = .body
        ) {
            self.defaultSize = defaultSize
            self.maxSize = maxSize
            self.relativeTo = relativeTo
        }
    }

    @ScaledMetric(wrappedValue: 24, relativeTo: .body)
    private var scaledMetricSize: CGFloat

    private let imageSource: ImageSource
    private let configuration: Configuration

    private var size: CGFloat {
        guard let maxSize = configuration.maxSize else {
            return scaledMetricSize
        }
        return min(maxSize, scaledMetricSize)
    }

    init(
        _ resource: ImageResource,
        configuration: Configuration = .init()
    ) {
        _scaledMetricSize = ScaledMetric(
            wrappedValue: configuration.defaultSize,
            relativeTo: configuration.relativeTo
        )
        self.imageSource = .resource(resource)
        self.configuration = configuration
    }
    
    public init(
        systemName: String,
        configuration: Configuration = .init()
    ) {
        _scaledMetricSize = ScaledMetric(
            wrappedValue: configuration.defaultSize,
            relativeTo: configuration.relativeTo
        )
        self.imageSource = .system(systemName)
        self.configuration = configuration
    }
 
    public var body: some View {
        switch imageSource {
        case .resource(let resource):
            Image(resource)
                .resizable()
                .frame(width: size, height: size)
        case .system(let name):
            Image(systemName: name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
    }
}
