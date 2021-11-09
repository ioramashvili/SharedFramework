import UIKit

public extension UIFont {
    var uppercasedFont: UIFont {
        let fontDescriptor = self.fontDescriptor

        let features: [UIFontDescriptor.AttributeName: Any] = [
            UIFontDescriptor.AttributeName.featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.featureIdentifier: kCaseSensitiveLayoutType,
                    UIFontDescriptor.FeatureKey.typeIdentifier: kCaseSensitiveLayoutOnSelector
                ]
            ]
        ]

        let featuredFontDescriptor = fontDescriptor.addingAttributes(features)
        return UIFont(descriptor: featuredFontDescriptor, size: pointSize)
    }
}
