extension InputFieldStyle {
    public static var `default`: InputFieldStyle {
        InputFieldStyle(variant: .default, background: .white)
    }

    public static var floating: InputFieldStyle {
        InputFieldStyle(variant: .floating, background: .white)
    }
}

extension InputFieldStyle {
    public func background(_ background: Configuration.Background) -> InputFieldStyle {
        InputFieldStyle(variant: variant, background: background)
    }
}
