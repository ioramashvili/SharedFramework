
public typealias AppSectionDataProviders = [AppSectionDataProvider]

open class AppListDataProvider {
    public fileprivate(set) var sectionDataProviders: AppSectionDataProviders
    
    public required init(sectionDataProviders: AppSectionDataProviders = []) {
        self.sectionDataProviders = sectionDataProviders
    }
    
    open var first: AppSectionDataProvider? {
        return sectionDataProviders.first
    }
    
    open var last: AppSectionDataProvider? {
        return sectionDataProviders.last
    }
    
    open func append(_ newElement: AppSectionDataProvider) {
        sectionDataProviders.append(newElement) 
    }
    
    open func append(contentsOf sectionDataProviders: AppSectionDataProviders) {
        sectionDataProviders.forEach { append($0) }
    }
    
    open func insert(_ newElement: AppSectionDataProvider, at index: Int) {
        sectionDataProviders.insert(newElement, at: index)
    }
    
    open func remove(at index: Int) {
        sectionDataProviders.remove(at: index)
    }
    
    open func removeAll() {
        sectionDataProviders.removeAll()
    }
    
    @discardableResult
    open func remove(element: AppSectionDataProvider) -> Bool {
        guard let index = sectionDataProviders.firstIndex(where: { $0 === element }) else {
            return false
        }
        
        remove(at: index)
        return true
    }
    
    open var count: Int {
        return sectionDataProviders.count
    }
    
    open var IsEmpty: Bool {
        return sectionDataProviders.isEmpty
    }
    
    open func sectionDataProvider(at index: Int) -> AppSectionDataProvider {
        return sectionDataProviders[index]
    }
    
    open func sectionDataProvider<T: AppSectionDataProvider>(of type: T.Type, at index: Int) -> T? {
        return sectionDataProvider(at: index) as? T
    }
    
    open func dataProvider(at indexPath: IndexPath) -> AppCellDataProvider {
        return sectionDataProvider(at: indexPath.section).dataProvider(at: indexPath)
    }
    
    open func dataProvider<T: AppCellDataProvider>(of type: T.Type, at indexPath: IndexPath) -> T? {
        return dataProvider(at: indexPath) as? T
    }
    
    open subscript(index: Int) -> AppSectionDataProvider {
        return sectionDataProvider(at: index)
    }
    
    open subscript(indexPath: IndexPath) -> AppCellDataProvider {
        return dataProvider(at: indexPath)
    }
    
    public var combinedDataProviders: AppCellDataProviders {
        return sectionDataProviders.reduce(AppCellDataProviders(), { $0 + $1.dataProviders })
    }
}





