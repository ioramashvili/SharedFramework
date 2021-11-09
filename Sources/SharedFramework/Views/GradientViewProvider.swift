import UIKit

public protocol GradientViewProvider {
    associatedtype GradientViewType where GradientViewType: CAGradientLayer
}

extension UIView: GradientViewProvider {
    public typealias GradientViewType = GradientLayer
}

public extension GradientViewProvider where Self: UIView {
    var gradientLayer: Self.GradientViewType {
        layer as! Self.GradientViewType
    }
}
