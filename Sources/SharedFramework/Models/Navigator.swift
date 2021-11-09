public protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination, animated animate: Bool)
}
