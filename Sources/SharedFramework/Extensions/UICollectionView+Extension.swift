import UIKit

extension UICollectionView {
    public func register(types: AppCollectionViewCell.Type...) {
        register(types: types.map { $0 })
    }

    public func register(types: [AppCollectionViewCell.Type]) {
        types.forEach {
            register($0.nib, forCellWithReuseIdentifier: $0.identifierValue)
        }
    }

    public func registerSupplementaryView(types: (AppCollectionReusableView.Type, AppSupplementaryKind)...) {
        registerSupplementaryView(types: types.map { $0 })
    }

    public func registerSupplementaryView(types: [(AppCollectionReusableView.Type, AppSupplementaryKind)]) {
        types.forEach { (type, kind) in
            register(type.nib, forSupplementaryViewOfKind: kind.value, withReuseIdentifier: type.identifierValue)
        }
    }
}

extension UICollectionView: UICollectionViewDequauable {
    public func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppCollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: dataProvider.identifier, for: indexPath) as! AppCollectionViewCell
    }

    open func dequeueReusable<T: AppCollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.identifierValue, for: indexPath) as! T
    }

    public func dequeueReusableSupplementary(dataProvider: AppSupplementaryViewDataProvider, for indexPath: IndexPath) -> AppCollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: dataProvider.kind.value, withReuseIdentifier: dataProvider.identifier, for: indexPath) as! AppCollectionReusableView
    }

    open func dequeueReusableSupplementary<T: AppCollectionReusableView>(view: T.Type, kind: AppSupplementaryKind, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind.value, withReuseIdentifier: T.identifierValue, for: indexPath) as! T
    }
}
