
open class AppCollectionViewCell: UICollectionViewCell, AppCellRepresentable {
    open class var nib: UINib {
        return UINib(nibName: className, bundle: Bundle(for: self))
    }
    
    open class var identifier: Identifierable {
        return ExampleAppCollectionViewCellType.unknown
    }
    
    open weak var dataProvider: AppCellDataProvider? {
        didSet {
            
        }
    }
}
