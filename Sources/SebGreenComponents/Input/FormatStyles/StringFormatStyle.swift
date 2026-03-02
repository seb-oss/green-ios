import Foundation

public struct StringFormatStyle: ParseableFormatStyle {
    public var parseStrategy: StringParseStrategy { StringParseStrategy() }

    public func format(_ value: String) -> String { value }

    public struct StringParseStrategy: ParseStrategy {
        public func parse(_ value: String) throws -> String { value }
    }
}
