public protocol AppCellRepresentable: class {
    static var nib: UINib { get }
    static var identifier: Identifierable { get }
}

public extension AppCellRepresentable {
    static var identifierValue: String {
        return identifier.identifier
    }
}
