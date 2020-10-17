@IBDesignable
open class AppShadowView: AppGradientView, ShadowView {
    @IBInspectable open var shadowOpacity: Float = 1 {
        didSet {
            update()
        }
    }

    @IBInspectable open var shadowOffset: CGSize = .zero {
        didSet {
            update()
        }
    }

    @IBInspectable open var shadowColor: UIColor = .clear {
        didSet {
            update()
        }
    }

    @IBInspectable open var shadowBlur: CGFloat = 3 {
        didSet {
            update()
        }
    }

    @IBInspectable open var hasShadowPath: Bool = true {
        didSet {
            update()
        }
    }

    open override func update() {
        super.update()

        setupShadow()
    }
}
