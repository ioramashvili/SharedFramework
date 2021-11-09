import UIKit

public protocol AppCellDelegate: AnyObject {
    func didSelect(at indexPath: IndexPath)
}
