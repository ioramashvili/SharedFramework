import UIKit

public protocol ShadowView: AnyObject {
    var shadowOpacity: Float { get set }
    var shadowOffset: CGSize { get set }
    var shadowColor: UIColor { get set }
    var shadowBlur: CGFloat { get set }
    var hasShadowPath: Bool { get set }
}

public extension ShadowView where Self: UIView, Self: CircularView {
    func setupShadow() {
        layer.shadowPath = nil

        layer.cornerRadius = normalizedCornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor

        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowBlur
        layer.masksToBounds = false

        if hasShadowPath {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: normalizedCornerRadius).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
