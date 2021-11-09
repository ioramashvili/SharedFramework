// MARK: Example Only

enum ExampleAppTableViewCellType: Int, Identifierable {
    case unknown = 0
    case large
    case medium
    case small

    public var identifier: String {
        "cell\(rawValue)"
    }
}

enum ExampleAppCollectionViewCellType: Int, Identifierable {
    case unknown = 0
    case large
    case medium
    case small

    public var identifier: String {
        "cell\(rawValue)"
    }
}
