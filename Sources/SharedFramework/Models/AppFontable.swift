import UIKit

extension AppFontable where Self: RawRepresentable, Self.RawValue == String {
    public var name: String {
        rawValue
    }

    public func with(size: CGFloat) -> UIFont {
        UIFont(name: name, size: size)!
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
