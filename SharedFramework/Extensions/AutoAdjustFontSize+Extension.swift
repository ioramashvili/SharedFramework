
public extension UILabel {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if let currentFont = font, newValue {
                font = Device.shared.normalized(font: currentFont)
            }
        }
        get {
            return false
        }
    }
}

public extension UIButton {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if let label = titleLabel, let currentFont = titleLabel?.font, newValue {
                label.font = Device.shared.normalized(font: currentFont)
            }
        }
        get {
            return false
        }
    }
}

public extension UITextField {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if let currentFont = font, newValue {
                font = Device.shared.normalized(font: currentFont)
            }
        }
        get {
            return false
        }
    }
}

public extension UITextView {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if let currentFont = font, newValue {
                font = Device.shared.normalized(font: currentFont)
            }
        }
        get {
            return false
        }
    }
}








