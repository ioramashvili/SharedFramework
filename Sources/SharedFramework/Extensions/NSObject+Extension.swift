import Foundation

extension NSObject {
    public var className: String {
        String(describing: type(of: self))
    }

    public class var className: String {
        String(describing: self)
    }
}
