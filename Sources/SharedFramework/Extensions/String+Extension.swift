extension String {
    public func capitalizingFirstLetter() -> String {
        prefix(1).uppercased() + dropFirst()
    }

    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
