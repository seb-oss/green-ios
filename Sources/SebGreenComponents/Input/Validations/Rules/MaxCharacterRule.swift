import Foundation
import Accessibility
// TODO: Remove import UIKit when minimum deployment target is iOS 17+
import UIKit

@available(iOS 16, *)
public struct MaxCharacterRule: ValidationRule {
    let maxCharacters: Int
    private let enforcement: Enforcement
    
    public init(maxCharacters: Int, enforcement: Enforcement) {
        self.maxCharacters = maxCharacters
        self.enforcement = enforcement
    }

    /// Defines how the character limit is enforced.
    public enum Enforcement {
        /// Warns the user when exceeding the limit but allows input to continue.
        case soft
        /// Prevents input from exceeding the limit by truncating excess characters.
        case hard
    }

    public func transform(_ value: String) -> ValidationTransformResult<String>? {
        guard case .hard = enforcement,
              hasExceededMaxCharacters(value) else {
            return nil
        }
        
        let format = String(
            localized: "GreeniOS.InputField.Accessibility.MaxCharactersReached.Announcement",
            bundle: .module
        )
        let message = String(format: format, maxCharacters)
        accessibilityAnnounce(message)

        return .init(
            value: String(value.prefix(maxCharacters)),
            feedback: .impact
        )
    }

    public func validate(_ value: String) throws(ValidationError) {
        if hasExceededMaxCharacters(value) {
            let localizedError = String(localized: "GreeniOS.InputField.Validation.MaxCharacters", bundle: .module)
            let errorMessage = String(format: localizedError, maxCharacters)
            accessibilityAnnounce(errorMessage)
            
            throw ValidationError(errorDescription: errorMessage)
        }
    }

    private func hasExceededMaxCharacters(_ value: String) -> Bool {
        value.count > maxCharacters
    }
    
    private func accessibilityAnnounce(_ message: String) {
        if #available(iOS 17, *) {
            var announcement = AttributedString(message)
            announcement.accessibilitySpeechAnnouncementPriority = .high
            AccessibilityNotification.Announcement(announcement)
                .post()
        } else {
            UIAccessibility.post(
                notification: .announcement,
                argument: message
            )
        }
    }
}

@available(iOS 16, *)
public extension ValidationRule where Self == MaxCharacterRule {
    static func maxCharacters(
        _ count: Int,
        enforcement: MaxCharacterRule.Enforcement = .soft
    ) -> Self {
        MaxCharacterRule(maxCharacters: count, enforcement: enforcement)
    }
}
