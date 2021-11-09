import UIKit

open class AppTableViewCell: UITableViewCell, AppCellRepresentable {
    public fileprivate(set) var isHeightPreCalculated = true

    open class var nib: UINib {
        UINib(nibName: className, bundle: Bundle(for: self))
    }

    open class var identifier: Identifierable {
        ExampleAppTableViewCellType.unknown
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    open weak var dataProvider: AppCellDataProvider? {
        didSet {

        }
    }
}

extension String: Identifierable {
    public var identifier: String {
        self
    }
}

extension AppTableViewCell {
    fileprivate func height(for tableViewWidth: CGFloat) -> CGFloat {
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

        bounds = CGRect(x: 0, y: 0, width: tableViewWidth, height: bounds.height)

        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        return ceil(size.height)
    }

    public class func height(for dataProvider: AppCellDataProvider, in tableView: UITableView, tableViewWidth: CGFloat?) -> CGFloat {
        let cell = tableView.dequeueReusable(dataProvider: dataProvider)
        cell.isHeightPreCalculated = false
        cell.dataProvider = dataProvider
        return cell.height(for: tableViewWidth ?? tableView.bounds.width)
    }

    @discardableResult
    public class func height(for dataProvider: StaticHeightDataProvider, in tableView: UITableView, tableViewWidth: CGFloat?) -> CGFloat {
        if dataProvider.isHeightSet {
            return dataProvider.height
        }

        dataProvider.height = height(for: dataProvider as AppCellDataProvider, in: tableView, tableViewWidth: tableViewWidth)

        return dataProvider.height
    }

    @discardableResult
    public class func height(for dataProvider: ExpandableDataProvider, in tableView: UITableView, tableViewWidth: CGFloat?) -> CGFloat {
        let currentState = dataProvider.state

        if !dataProvider.isExpanedHeightSet {
            dataProvider.state = .expanded
            let expandedHeight = height(
                for: dataProvider as AppCellDataProvider,
                in: tableView,
                tableViewWidth: tableViewWidth)
            dataProvider.expandedHeight = expandedHeight
        }

        if !dataProvider.isCollapsedHeightSet {
            dataProvider.state = .collapsed
            let collapsedHeight = height(
                for: dataProvider as AppCellDataProvider,
                in: tableView,
                tableViewWidth: tableViewWidth)
            dataProvider.collapsedHeight = collapsedHeight
        }

        dataProvider.state = currentState

        return dataProvider.height
    }

}

// Eample cell
//
//final class CountryCell: ContentNodeRendererCell {
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var separator: UIView!
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.layoutIfNeeded()
//
//        if !isHeightPreCalculated {
//            nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
//        }
//    }
//}
