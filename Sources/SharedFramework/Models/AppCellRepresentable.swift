import UIKit

public protocol AppCellRepresentable: AnyObject {
    static var nib: UINib { get }
    static var identifier: Identifierable { get }
}

public extension AppCellRepresentable {
    static var identifierValue: String {
        identifier.identifier
    }
}
