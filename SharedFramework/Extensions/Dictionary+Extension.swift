extension Dictionary {
    public mutating func addIfNotNil(key: Dictionary.Key, value: Dictionary.Value?) {
        guard let value = value else { return }
        self[key] = value
    }
}
