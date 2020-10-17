public protocol AppColorable {
    var color: UIColor { get }
    var hexString: String { get }
}

public extension AppColorable where Self: RawRepresentable, Self.RawValue == String {
    var hexString: String {
        return rawValue
    }

    var color: UIColor {
        return getColor(from: self)
    }

    private func getColor(from colorable: AppColorable) -> UIColor {
        var cString = colorable.hexString.trimmingCharacters(in: .whitespacesAndNewlines)

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count == 6 {
            cString += "FF"
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let red   = CGFloat((rgbValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbValue      ) & 0xff) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
