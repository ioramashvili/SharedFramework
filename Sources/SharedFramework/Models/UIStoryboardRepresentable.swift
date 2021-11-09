import UIKit

public protocol UIStoryboardRepresentable: UIStoryboardInstantiatable {
    var storyboard: UIStoryboard { get }
    var bundle: Bundle { get }
}

public extension UIStoryboardRepresentable where Self: RawRepresentable, Self.RawValue == String {
    var storyboard: UIStoryboard {
        UIStoryboard.init(name: rawValue, bundle: bundle)
    }

    var rawValue: String {
        "\(self)".capitalizingFirstLetter()
    }
}
