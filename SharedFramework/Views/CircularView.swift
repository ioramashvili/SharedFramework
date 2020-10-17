public protocol CircularView: class {
    var hasSquareBorderRadius: Bool { get set }
    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
    var normalizedCornerRadius: CGFloat { get }
    var borderLayer: CAShapeLayer { get }
    var maskLayer: CAShapeLayer { get }

    func makeMaskLayerPath() -> UIBezierPath
    func makeMaskLayer(path: UIBezierPath) -> CAShapeLayer
}

public extension CircularView where Self: UIView {
    func setupCornerRadius() {
//        let maskPath = makeMaskLayerPath()
//        layer.mask = makeMaskLayer(path: maskPath)

//        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = maskLayer.path
//        animation.toValue = maskPath.cgPath
//        animation.duration = 0.2
//
//        maskLayer.add(animation, forKey: "animation")
//        maskLayer.path = maskPath.cgPath
//        print(bounds)
//        print(normalizedCornerRadius, hasSquareBorderRadius)
        layer.cornerRadius = normalizedCornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true

//        borderLayer.path = maskPath.cgPath
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.strokeColor = borderColor.cgColor
//        borderLayer.lineWidth = borderWidth
    }

    func makeMaskLayerPath() -> UIBezierPath {
        return UIBezierPath.init(roundedRect: bounds, cornerRadius: normalizedCornerRadius)
    }

    func makeMaskLayer(path: UIBezierPath) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        return maskLayer
    }
}
