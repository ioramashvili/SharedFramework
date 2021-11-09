import UIKit

extension UITableView {
    public func register(types: AppTableViewCell.Type...) {
        register(types: types.map { $0 })
    }

    public func register(types: [AppTableViewCell.Type]) {
        types.forEach {
            register($0.nib, forCellReuseIdentifier: $0.identifierValue)
        }
    }
}

extension UITableView: UITableViewDequauable {
    public func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppTableViewCell {
        dequeueReusableCell(withIdentifier: dataProvider.identifier, for: indexPath) as! AppTableViewCell
    }

    public func dequeueReusable(dataProvider: AppCellDataProvider) -> AppTableViewCell {
        dequeueReusableCell(withIdentifier: dataProvider.identifier) as! AppTableViewCell
    }

    open func dequeueReusable<T: AppTableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifierValue, for: indexPath) as! T
    }

    open func dequeueReusable<T: AppTableViewCell>(cell: T.Type) -> T? {
        dequeueReusableCell(withIdentifier: T.identifierValue) as? T
    }
}
