public protocol Builder {
    associatedtype Buildable

    func build() -> Buildable
}
