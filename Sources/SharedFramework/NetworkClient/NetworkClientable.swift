import Foundation

public protocol NetworkClientable: ServerInfo {
    associatedtype Method: Methodable
}

extension NetworkClientable {
    public static func cacheRequest(for method: Method) -> NetworkClientCacheRequest {
        NetworkClientCacheRequest(method: method)
    }

    public static func clearCache(for method: Method) {
        try? FileManager.default.removeItem(at: method.targetCacheFolderUrl)
    }
}
