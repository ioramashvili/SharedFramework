import UIKit

open class PushViewControllerNotifiableNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setDelegate()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setDelegate()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDelegate()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }

    fileprivate func setDelegate() {
        delegate = self
    }

    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? PushViewControllerNotifiable)?.navigationController(navigationController, willShow: viewController, animated: animated)
    }

    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (viewController as? PushViewControllerNotifiable)?.navigationController(navigationController, didShow: viewController, animated: animated)
    }
}

extension UINavigationController {
    public func pushViewController(viewController: PushViewControllerNotifiableViewController, willShow: PushViewControllerNotifiableComplition?, didShow: PushViewControllerNotifiableComplition?, animated: Bool) {
        viewController.registerComplitions(willShowComplition: willShow, didShowComplition: didShow)
        pushViewController(viewController, animated: animated)
    }
}
