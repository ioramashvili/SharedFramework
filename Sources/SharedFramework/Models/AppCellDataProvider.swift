public protocol AppCellDataProvider: AnyObject, Identifierable {

}

public extension AppCellDataProvider {
    func to<T: AppCellDataProvider>(_ type: T.Type) -> T? {
        self as? T
    }
}
