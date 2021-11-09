import UIKit

open class AppCollectionViewCell: UICollectionViewCell, AppCellRepresentable {
    open class var nib: UINib {
        UINib(nibName: className, bundle: Bundle(for: self))
    }

    open class var identifier: Identifierable {
        ExampleAppCollectionViewCellType.unknown
    }

    open weak var dataProvider: AppCellDataProvider? {
        didSet {

        }
    }
}
