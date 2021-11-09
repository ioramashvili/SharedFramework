import UIKit

public typealias PushViewControllerNotifiableComplition = () -> Void

public protocol PushViewControllerNotifiable: AnyObject {
    var willShowComplition: PushViewControllerNotifiableComplition? { get set }
    var didShowComplition: PushViewControllerNotifiableComplition? { get set }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
}

extension PushViewControllerNotifiable {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? PushViewControllerNotifiableViewController)?.fireWillShowComplitionAndClear()
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (viewController as? PushViewControllerNotifiableViewController)?.fireDidShowComplitionAndClear()
    }

    func registerComplitions(willShowComplition: PushViewControllerNotifiableComplition?, didShowComplition: PushViewControllerNotifiableComplition?) {
        self.willShowComplition = willShowComplition
        self.didShowComplition = didShowComplition
    }

    func fireWillShowComplitionAndClear() {
        willShowComplition?()
        willShowComplition = nil
    }

    func fireDidShowComplitionAndClear() {
        didShowComplition?()
        didShowComplition = nil
    }
}

open class PushViewControllerNotifiableViewController: UIViewController, PushViewControllerNotifiable {
    public var willShowComplition: PushViewControllerNotifiableComplition?
    public var didShowComplition: PushViewControllerNotifiableComplition?
}

open class PushViewControllerNotifiableTableViewController: UITableViewController, PushViewControllerNotifiable {
    public var willShowComplition: PushViewControllerNotifiableComplition?
    public var didShowComplition: PushViewControllerNotifiableComplition?
}

open class PushViewControllerNotifiableCollectionViewController: UICollectionViewController, PushViewControllerNotifiable {
    public var willShowComplition: PushViewControllerNotifiableComplition?
    public var didShowComplition: PushViewControllerNotifiableComplition?
}
