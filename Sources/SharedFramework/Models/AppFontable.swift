import UIKit

extension AppFontable where Self: RawRepresentable, Self.RawValue == String {
    public var name: String {
        rawValue
    }

    public func with(size: CGFloat) -> UIFont {
        UIFont(name: name, size: size)!
    }
}

public protocol AppFontable {
    var name: String { get }
    func with(size: CGFloat) -> UIFont
}

public func printFontNames() {
    for family in UIFont.familyNames {
        print("\(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
            print("   \(name)")
        }
    }
}
