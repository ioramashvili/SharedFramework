import Foundation

public protocol Methodable {
    /// Unique numeric value
    var number: Int { get }

    /// Method name, like getArticles.php or articles/all
    var name: String? { get }

    /// ServerInfo
    var serverInfo: ServerInfo.Type { get }

    /// Appending name component to baseUrl
    var requestUrl: URL { get }

    /// header values as [String: String]
    var headerValues: HeaderValues? { get }
}

extension Methodable {
    public var requestUrl: URL {
        guard let name = name else { return serverInfo.baseUrl }
        return serverInfo.baseUrl.appendingPathComponent(name)
    }

    public var cacheRequest: NetworkClientCacheRequest {
        NetworkClientCacheRequest(method: self)
    }

    public var targetCacheFolderUrl: URL {
        serverInfo.documentDirectory.appendingPathComponent("\(serverInfo.cacheRootFolderName)/\(number)")
    }

    fileprivate func createCacheFolderIfNeeded() throws {
        let fileManager = FileManager.default
        let path = targetCacheFolderUrl.path
        guard !fileManager.fileExists(atPath: path) else {return}
        try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }

    public func createCacheFolderIfNeededAndReturn() throws -> URL {
        try createCacheFolderIfNeeded()
        return targetCacheFolderUrl
    }

    public func getCachePath(for fileName: String) throws -> URL {
        let url = try createCacheFolderIfNeededAndReturn()
        return url.appendingPathComponent(fileName)
    }
}
