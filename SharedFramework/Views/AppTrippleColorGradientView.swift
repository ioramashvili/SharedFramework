@IBDesignable
open class AppTrippleColorGradientView: AppGradientView {
    @IBInspectable open var color3: UIColor = .clear {
        didSet {
            update()
        }
    }

    @IBInspectable open var location3: Double = 1 {
        didSet {
            update()
        }
    }

    @IBInspectable open var hasEqualTransition: Bool = true {
        didSet {
            update()
        }
    }

    open override var colors: [CGColor] {
        return super.colors + [color3.cgColor]
    }

    open override var locations: [NSNumber] {
        return hasEqualTransition ? [0, 0.5, 1] : super.locations + [NSNumber.init(value: location3)]
    }
}
