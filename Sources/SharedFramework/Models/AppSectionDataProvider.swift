import UIKit

public typealias AppCellDataProviders = [AppCellDataProvider]

open class AppSectionDataProvider {
    public var header: AppCellDataProvider?
    public var dataProviders: AppCellDataProviders
    public var footer: AppCellDataProvider?

    public required init(header: AppCellDataProvider? = nil, dataProviders: AppCellDataProviders = [], footer: AppCellDataProvider? = nil) {
        self.header = header
        self.dataProviders = dataProviders
        self.footer = footer
    }

    open func append(_ newElement: AppCellDataProvider) {
        dataProviders.append(newElement)
    }

    open func append(contentsOf dataProviders: AppCellDataProviders) {
        dataProviders.forEach { append($0) }
    }

    open func insert(_ newElement: AppCellDataProvider, at index: Int) {
        dataProviders.insert(newElement, at: index)
    }

    open func remove(at index: Int) {
        dataProviders.remove(at: index)
    }

    open func removeAll() {
        dataProviders.removeAll()
    }

    @discardableResult
    open func remove(element: AppCellDataProvider) -> Bool {
        guard let index = dataProviders.firstIndex(where: { $0 === element }) else {
            return false
        }

        remove(at: index)
        return true
    }

    open var count: Int {
        dataProviders.count
    }

    open var IsEmpty: Bool {
        dataProviders.isEmpty
    }

    open func dataProvider(at index: Int) -> AppCellDataProvider {
        dataProviders[index]
    }

    open func dataProvider<T: AppCellDataProvider>(of type: T.Type, at index: Int) -> T? {
        dataProvider(at: index) as? T
    }

    open func dataProvider(at indexPath: IndexPath) -> AppCellDataProvider {
        dataProviders[indexPath.row]
    }

    open func dataProvider<T: AppCellDataProvider>(of type: T.Type, at indexPath: IndexPath) -> T? {
        dataProvider(at: indexPath) as? T
    }

    open subscript(index: Int) -> AppCellDataProvider {
        dataProvider(at: index)
    }

    open subscript(indexPath: IndexPath) -> AppCellDataProvider {
        dataProvider(at: indexPath)
    }

    open func indexOf(_ element: AppCellDataProvider) -> Int? {
        dataProviders.firstIndex(where: { $0 === element })
    }
}

public extension AppSectionDataProvider {
    var hasHeader: Bool {
        header != nil
    }

    func removeHeader() {
        header = nil
    }

    var hasFooter: Bool {
        footer != nil
    }

    func removeFooter() {
        footer = nil
    }
}

public extension AppSectionDataProvider {
    convenience init(header: AppCellDataProvider?, dataProviders: AppCellDataProviders) {
        self.init(header: header, dataProviders: dataProviders, footer: nil)
    }

    convenience init(dataProviders: AppCellDataProviders, footer: AppCellDataProvider?) {
        self.init(header: nil, dataProviders: dataProviders, footer: footer)
    }

    convenience init(header: AppCellDataProvider?, footer: AppCellDataProvider?) {
        self.init(header: header, dataProviders: [], footer: footer)
    }

    convenience init(header: AppCellDataProvider?) {
        self.init(header: header, dataProviders: [], footer: nil)
    }

    convenience init(footer: AppCellDataProvider?) {
        self.init(header: nil, dataProviders: [], footer: footer)
    }

    convenience init(dataProviders: AppCellDataProviders) {
        self.init(header: nil, dataProviders: dataProviders, footer: nil)
    }
}
