extension AppFontable where Self: RawRepresentable, Self.RawValue == String {
    public var name: String {
        return rawValue
    }

    public func with(size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }

    public func withAdjustedToRealIPhone(size: CGFloat) -> UIFont {
        let normalizedSize = Device.shared.normalized(fontSize: size)
        return UIFont(name: name, size: normalizedSize)!
    }
}

public protocol AppFontable {
    var name: String { get }
    func with(size: CGFloat) -> UIFont
    func withAdjustedToRealIPhone(size: CGFloat) -> UIFont
}

public func printFontNames() {
    for family in UIFont.familyNames {
        print("\(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
            print("   \(name)")
        }
    }
}

// Example
//enum AppFont: String, AppFontable {
//    case base = "MyGeocell-Regular"
//    case notosansbold = "NotoSans-Bold"
//    case notosansregular = "NotoSans"
//    case bpgPhoneSans = "BPGPhoneSans"
//    case bpgPhoneSansBold = "BPGPhoneSans-Bold"
//    case bpgArial2010 = "BPGArial2010"
//    case bpgGEL = "!BPGGEL"
//}
