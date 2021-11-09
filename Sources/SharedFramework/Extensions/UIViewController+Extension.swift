import UIKit

extension UIViewController {
    public func to<T: UIViewController>(_ type: T.Type) -> T? {
        self as? T
    }

    public func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    public func remove() {
        guard parent != nil else {return}

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIViewController {
    public func wrap<T: UINavigationController>(in navigationController: T.Type) -> T {
        T(rootViewController: self)
    }
}

extension UIViewController {
    public var isPortrait: Bool {
        UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
}
