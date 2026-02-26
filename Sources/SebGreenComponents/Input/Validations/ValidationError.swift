import Foundation

public struct ValidationError: LocalizedError {
    public let errorDescription: String?
    let sensoryFeedback: HapticFeedback?

    public init(
        errorDescription: String?,
        sensoryFeedback: HapticFeedback? = .error
    ) {
        self.errorDescription = errorDescription
        self.sensoryFeedback = sensoryFeedback
    }
}
