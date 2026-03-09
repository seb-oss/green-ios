import SwiftUI

extension InputFieldStyle {
    public struct Configuration {
        let background: Background

        public init(background: Background) {
            self.background = background
        }

        public enum Background {
            case white, gray

            var color: Color {
                switch self {
                case .white: Color.l2Neutral02
                case .gray: Color.l2Neutral01
                }
            }
        }
    }
}
