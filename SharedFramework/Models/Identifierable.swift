public protocol Identifierable {
    var identifier: String { get }
}

public func ==(left: Identifierable, right: Identifierable) -> Bool {
    return left.identifier == right.identifier
}
