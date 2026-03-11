import Foundation

public struct ValidationError: LocalizedError {
    public let errorDescription: String?
    let sensoryFeedback: HapticFeedback?

    public init(
        _ errorDescription: String?,
        sensoryFeedback: HapticFeedback? = nil
    ) {
        self.errorDescription = errorDescription
        self.sensoryFeedback = sensoryFeedback
    }
}
