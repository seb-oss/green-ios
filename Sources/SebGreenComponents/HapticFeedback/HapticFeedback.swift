import SwiftUI

@available(iOS, deprecated: 17.0, renamed: "SensoryFeedback", message: "Use Apple's native SensoryFeedback instead.")
public enum HapticFeedback: Sendable {
    case success
    case warning
    case error
    case selection
    case increase
    case decrease
    case start
    case stop
    case alignment
    case levelChange
    case pathComplete
    case impactWeight(weight: HapticFeedback.Weight, intensity: Double)
    case impactFlexibility(flexibility: HapticFeedback.Flexibility, intensity: Double)

    public enum Weight: Sendable {
        case light
        case medium
        case heavy
    }

    public enum Flexibility: Sendable {
        case rigid
        case solid
        case soft
    }
}

@available(iOS 17.0, *)
extension SensoryFeedback {
    fileprivate init(_ feedbackType: HapticFeedback) {
        switch feedbackType {
        case .start:
            self = .start
        case .stop:
            self = .stop
        case .alignment:
            self = .alignment
        case .decrease:
            self = .decrease
        case .increase:
            self = .increase
        case .levelChange:
            self = .levelChange
        case .selection:
            self = .selection
        case .success:
            self = .success
        case .warning:
            self = .warning
        case .error:
            self = .error
        case .impactWeight(let weight, intensity: let intensity):
            self = .impact(weight: .init(weight), intensity: intensity)
        case .impactFlexibility(let flexibility, intensity: let intensity):
            self = .impact(
                flexibility: .init(flexibility),
                intensity: intensity
            )
        case .pathComplete:
            if #available(iOS 17.5, *) {
                self = .pathComplete
            } else {
                self = .impact // Just fallback to a generic impact if pathComplete is not available
            }
        }
    }
}

@available(iOS 17.0, *)
extension SensoryFeedback.Weight {
    fileprivate init(_ weight: HapticFeedback.Weight) {
        switch weight {
        case .heavy: self = .heavy
        case .medium: self = .medium
        case .light: self = .light
        }
    }
}

@available(iOS 17.0, *)
extension SensoryFeedback.Flexibility {
    fileprivate init(_ flexibility: HapticFeedback.Flexibility) {
        switch flexibility {
        case .rigid:
            self = .rigid
        case .solid:
            self = .solid
        case .soft:
            self = .soft
        }
    }
}

/// Applies sensory feedback on iOS 17+, no-op on earlier versions.
extension View {
    @available(
        iOS,
        deprecated: 17,
        renamed: "sensoryFeedback",
        message: "Use Apple's native sensoryFeedback modifier instead."
    )
    @ViewBuilder
    func sensoryFeedbackIfAvailable(trigger: some Equatable, _ feedback: @escaping () -> HapticFeedback?) -> some View {
        if #available(iOS 17, *) {
            self
                .sensoryFeedback(trigger: trigger) {
                    if let feedback = feedback() {
                        SensoryFeedback(feedback)
                    } else {
                        nil
                    }
                }
        } else {
            self
        }
    }
    
    @available(
        iOS,
        deprecated: 17,
        renamed: "sensoryFeedback",
        message: "Use Apple's native sensoryFeedback modifier instead."
    )
    @ViewBuilder
    func sensoryFeedbackIfAvailable(_ feedback: HapticFeedback, trigger: some Equatable) -> some View {
        if #available(iOS 17, *) {
            self
                .sensoryFeedback(SensoryFeedback(feedback), trigger: trigger)
        } else {
            self
        }
    }
}
