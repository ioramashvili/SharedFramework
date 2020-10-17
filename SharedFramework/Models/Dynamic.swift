open class Dynamic<T> {
    public typealias Listener = (T) -> Void
    public fileprivate(set) var listener: Listener?

    open func bind(_ listener: Listener?) {
        self.listener = listener
    }

    open func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    open var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ v: T) {
        value = v
    }
}
