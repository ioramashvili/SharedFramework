import UIKit

public protocol UIStoryboardInstantiatable {
    func instantiate<T: UIViewController>(controller: T.Type) -> T?
    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T?
    func instantiateInitial() -> UIViewController?
}

public extension UIStoryboardInstantiatable {
    func instantiateInitial() -> UIViewController? {
        instantiateInitial(controller: UIViewController.self)
    }
}

public extension UIStoryboardInstantiatable where Self: UIStoryboardRepresentable {
    func instantiate<T: UIViewController>(controller: T.Type) -> T? {
        storyboard.instantiate(controller: T.self)
    }

    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T? {
        storyboard.instantiateInitial(controller: T.self)
    }
}

public extension UIStoryboardInstantiatable where Self: UIStoryboard {
    func instantiate<T: UIViewController>(controller: T.Type) -> T? {
        instantiateViewController(withIdentifier: T.className) as? T
    }

    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T? {
        instantiateInitialViewController() as? T
    }
}
