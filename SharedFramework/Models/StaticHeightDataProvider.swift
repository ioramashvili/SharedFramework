
public protocol StaticHeightDataProvider: AppCellDataProvider {
    var height: CGFloat { get set }
    var isHeightSet: Bool { get }
}

