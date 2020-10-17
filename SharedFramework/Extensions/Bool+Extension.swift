extension Bool {
    public mutating func reverse() {
        self = !self
    }

    @discardableResult
    public func reversed() -> Bool {
        return !self
    }
}
