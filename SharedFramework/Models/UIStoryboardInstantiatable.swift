public protocol UIStoryboardInstantiatable {
    func instantiate<T: UIViewController>(controller: T.Type) -> T?
    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T?
    func instantiateInitial() -> UIViewController?
}

public extension UIStoryboardInstantiatable {
    // იძახებს instantiateInitial(controller:)
    // იმ შემთვევისთვის თუ გვინდა სთორიბორდის საწყისი ვიუკონტროლერი და არ გვინდა ტიპის დაზუსტება
    func instantiateInitial() -> UIViewController? {
        return instantiateInitial(controller: UIViewController.self)
    }
}

public extension UIStoryboardInstantiatable where Self: UIStoryboardRepresentable {
    func instantiate<T: UIViewController>(controller: T.Type) -> T? {
        return storyboard.instantiate(controller: T.self)
    }

    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T? {
        return storyboard.instantiateInitial(controller: T.self)
    }
}

public extension UIStoryboardInstantiatable where Self: UIStoryboard {
    // ვიღებთ ვიუკონტროლერს კონკრეტულ ტიპზე
    func instantiate<T: UIViewController>(controller: T.Type) -> T? {
        return instantiateViewController(withIdentifier: T.className) as? T
    }

    // ვიღებთ სთორიბორდის საწყის ვიუკონტროლერს კონკრეტული ტიპზე
    func instantiateInitial<T: UIViewController>(controller: T.Type) -> T? {
        return instantiateInitialViewController() as? T
    }
}
