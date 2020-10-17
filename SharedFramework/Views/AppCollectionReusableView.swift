open class AppCollectionReusableView: UICollectionReusableView, AppCellRepresentable {
    open class var nib: UINib {
        return UINib(nibName: className, bundle: Bundle(for: self))
    }

    open class var identifier: Identifierable {
        return ExampleAppCollectionViewCellType.unknown
    }

    open weak var dataProvider: AppSupplementaryViewDataProvider? {
        didSet {

        }
    }
}
