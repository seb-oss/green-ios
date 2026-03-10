public struct ValidationTransformResult<Value> {
    let value: Value
    let feedback: HapticFeedback?

    public init(value: Value, feedback: HapticFeedback? = nil) {
        self.value = value
        self.feedback = feedback
    }
}
