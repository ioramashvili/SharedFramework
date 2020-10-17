import UIKit

open class AppTableViewController: UITableViewController {

    open var dataProvider: AppListDataProvider? {
        didSet {
            tableView.reloadData()
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedSectionHeaderHeight = 20
        tableView.estimatedSectionFooterHeight = 20
    }

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider?.count ?? 0
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider?.sectionDataProvider(at: section).count ?? 0
    }

    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataProvider = sectionDataProvider(at: section).header else {return nil}
        return headerFooterView(for: dataProvider)
    }

    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let dataProvider = sectionDataProvider(at: section).footer else {return nil}
        return headerFooterView(for: dataProvider)
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataProvider = dataProvider?[indexPath] else {fatalError("item not found at indexPath \(indexPath)")}
        let cell = tableView.dequeueReusable(dataProvider: dataProvider, for: indexPath)
        cell.dataProvider = dataProvider
        return cell
    }

    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return height(for: sectionDataProvider(at: section).header)
    }

    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: dataProvider?[indexPath])
    }

    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return height(for: sectionDataProvider(at: section).footer)
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (dataProvider?[indexPath] as? AppCellDelegate)?.didSelect(at: indexPath)
    }
}

fileprivate extension AppTableViewController {
    func sectionDataProvider(at index: Int) -> AppSectionDataProvider {
        guard let sectionDataProvider = dataProvider?[index] else {fatalError("section not found at index \(index)")}
        return sectionDataProvider
    }

    func headerFooterView(for dataProvider: AppCellDataProvider) -> UIView {
        let cell = tableView.dequeueReusable(dataProvider: dataProvider)
        cell.dataProvider = dataProvider
        return cell.contentView
    }

    func height(for dataProvider: AppCellDataProvider?) -> CGFloat {
        guard let item = dataProvider else {return 0}

        if let expandable = item as? ExpandableDataProvider {
            return AppTableViewCell.height(for: expandable, in: tableView, tableViewWidth: nil)
        }

        if let staticHeight = item as? StaticHeightDataProvider {
            return AppTableViewCell.height(for: staticHeight, in: tableView, tableViewWidth: nil)
        }

        return UITableView.automaticDimension
    }
}
