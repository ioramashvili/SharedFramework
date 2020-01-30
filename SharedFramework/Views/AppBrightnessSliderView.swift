
@IBDesignable
open class AppBrightnessSliderView: AppCircularView {
    fileprivate let minBrightness: CGFloat = 0
    fileprivate let maxBrightness: CGFloat = 1
    fileprivate var panGesture: UIPanGestureRecognizer!
    fileprivate var brightnessIndicatorViewGestureFrame: CGRect = .zero
    
    @IBInspectable open var brightnessIndicatorViewColor: UIColor = .red {
        didSet {
            setupBrightnessIndicatorView()
        }
    }
    
    @IBInspectable open var isHorizontal: Bool = true {
        didSet {
            setupBrightnessIndicatorView()
        }
    }
    
    fileprivate lazy var brightnessIndicatorView: UIView = { [unowned self] in
        let v = UIView()
        self.addSubview(v)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupBrightnessIndicatorView()
    }
    
    fileprivate func initialize() {
        clipsToBounds = true
        initializePanGesture()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setupBrightnessIndicatorView),
            name: UIScreen.brightnessDidChangeNotification,
            object: nil)
    }
    
    fileprivate func initializePanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureDidChange(sender:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func panGestureDidChange(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        switch sender.state {
        case .began:
            cacheCurrentBrightnessIndicatorViewFrame()
            changeBrightness(by: translation)
        case .changed:
            changeBrightness(by: translation)
        default:
            cacheCurrentBrightnessIndicatorViewFrame()
        }
    }
    
    fileprivate func cacheCurrentBrightnessIndicatorViewFrame() {
        brightnessIndicatorViewGestureFrame = brightnessIndicatorView.frame
    }
    
    fileprivate func changeBrightness(by translation: CGPoint) {
        if isHorizontal {
            brightnessIndicatorView.frame.size.width = min(max(0, brightnessIndicatorViewGestureFrame.width + translation.x), bounds.width)
            let brightness = brightnessIndicatorView.frame.size.width / bounds.width
            UIScreen.main.brightness = normalized(brightness: brightness)
        } else {
            brightnessIndicatorView.frame.size.height = min(max(0, brightnessIndicatorViewGestureFrame.height + (-translation.y)), bounds.height)
            let brightness = brightnessIndicatorView.frame.size.height / bounds.height
            UIScreen.main.brightness = normalized(brightness: brightness)
        }
    }
    
    fileprivate func normalized(brightness: CGFloat) -> CGFloat {
        return min(max(minBrightness, brightness), maxBrightness)
    }
    
    @objc public func setupBrightnessIndicatorView() {
        brightnessIndicatorView.backgroundColor = brightnessIndicatorViewColor
        brightnessIndicatorView.frame = bounds
        
        if isHorizontal {
            brightnessIndicatorView.frame.size.width = bounds.width * UIScreen.main.brightness
        } else {
            brightnessIndicatorView.frame.size.height = bounds.height * UIScreen.main.brightness
            brightnessIndicatorView.frame.origin.y = bounds.height - brightnessIndicatorView.frame.size.height
        }
    }
    
    public func brightnessIndicatorView(isHidden: Bool) {
        brightnessIndicatorView.isHidden = isHidden
    }
    
    @available(iOS 10.0, *)
    public func animateBrightnessIndicatorView(withDuration duration: TimeInterval) {
        brightnessIndicatorView.frame.size.width = 0
        brightnessIndicatorView(isHidden: false)
        
        //        let animation = UIViewPropertyAnimator.init(
        //            duration: 1,
        //            controlPoint1: CGPoint.init(x: 0.88, y: 0.1),
        //            controlPoint2: CGPoint.init(x: 0.83, y: 0.88)) {
        //                self.setupBrightnessIndicatorView()
        //        }
        
        let animation = UIViewPropertyAnimator.init(
            duration: duration,
            controlPoint1: CGPoint.init(x: 0.96, y: 0.04),
            controlPoint2: CGPoint.init(x: 0.5, y: 0.97)) {
                self.setupBrightnessIndicatorView()
        }
        
        animation.startAnimation()
    }
}






