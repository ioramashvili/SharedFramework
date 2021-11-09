import UIKit

public protocol UICollectionViewDequauable {
    func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppCollectionViewCell
    func dequeueReusable<T: AppCollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T

    func dequeueReusableSupplementary(dataProvider: AppSupplementaryViewDataProvider, for indexPath: IndexPath) -> AppCollectionReusableView
    func dequeueReusableSupplementary<T: AppCollectionReusableView>(view: T.Type, kind: AppSupplementaryKind, for indexPath: IndexPath) -> T
}
