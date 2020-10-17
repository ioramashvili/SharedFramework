public protocol AppCellDataProvider: class, Identifierable {

}

public extension AppCellDataProvider {
    func to<T: AppCellDataProvider>(_ type: T.Type) -> T? {
        return self as? T
    }
}
