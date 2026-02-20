import SwiftUI

// TODO: What to do with this one?
struct Icon: View {
    @ScaledMetric(wrappedValue: 24, relativeTo: .body) private
        var scaledMetricSize: CGFloat

    private let resource: ImageResource
    private let configuration: Configuration

    private var size: CGFloat {
        guard let maxSize = configuration.maxSize else {
            return scaledMetricSize
        }
        return min(maxSize, scaledMetricSize)
    }

    struct Configuration {
        let defaultSize: CGFloat
        let maxSize: CGFloat?

        init(
            defaultSize: CGFloat = 24,
            maxSize: CGFloat? = nil
        ) {
            self.defaultSize = defaultSize
            self.maxSize = maxSize
        }
    }

    public init(
        _ resource: ImageResource,
        configuration: Configuration = .init(),
    ) {
        _scaledMetricSize = ScaledMetric(
            wrappedValue: configuration.defaultSize,
            relativeTo: .body
        )
        self.resource = resource
        self.configuration = configuration
    }

    var body: some View {
        Image(resource)
            .resizable()
            .frame(width: size, height: size)
    }
}
