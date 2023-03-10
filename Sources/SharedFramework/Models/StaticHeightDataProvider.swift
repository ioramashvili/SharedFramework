import UIKit

public protocol StaticHeightDataProvider: AppCellDataProvider {
    var height: CGFloat { get }
}
