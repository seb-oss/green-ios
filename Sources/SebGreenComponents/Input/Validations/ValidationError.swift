import Foundation

struct ValidationError: LocalizedError {
    let errorDescription: String?
    let sensoryFeedback: HapticFeedback?

    init(
        errorDescription: String?,
        sensoryFeedback: HapticFeedback? = .error
    ) {
        self.errorDescription = errorDescription
        self.sensoryFeedback = sensoryFeedback
    }
}
