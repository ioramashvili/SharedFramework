
open class GradientLayer : CAGradientLayer {
    var direction: GradientDirection? {
        didSet {
            startPoint = direction?.gradientType.x ?? .zero
            endPoint = direction?.gradientType.y ?? .zero
        }
    }
}
