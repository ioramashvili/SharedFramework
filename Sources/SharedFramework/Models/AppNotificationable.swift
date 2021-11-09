import UIKit

public protocol AppNotificationable {
    var name: String { get }
    var notificationName: NSNotification.Name { get }
}

public extension AppNotificationable where Self: RawRepresentable, Self.RawValue == String {
    var name: String {
        rawValue
    }

    func remove(observer: Any, object: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: notificationName, object: object)
    }
}

public extension AppNotificationable {
    var notificationName: NSNotification.Name {
        NSNotification.Name(rawValue: name)
    }

    func post(object anObject: Any? = nil, userInfo aUserInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: notificationName, object: anObject, userInfo: aUserInfo)
    }

    func addObserver(_ observer: Any, selector aSelector: Selector, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: notificationName, object: anObject)
    }

    func removeObserver(_ observer: Any, object anObject: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: notificationName, object: anObject)
    }
}
