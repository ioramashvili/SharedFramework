import Foundation

public protocol ServerInfo: AnyObject {
    static var scheme: String { get }
    static var host: String { get }
    static var path: String { get }
    static var baseUrl: URL { get }
}

extension ServerInfo {
    public static var baseUrl: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host   = host
        components.path   = path
        return components.url!
    }

    public static var cacheRootFolderName: String {
        String(describing: self)
    }

    public static func clearCache() {
        let folderPath =  documentDirectory.appendingPathComponent("\(cacheRootFolderName)")

        try? FileManager.default.removeItem(at: folderPath)
    }

    public static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
