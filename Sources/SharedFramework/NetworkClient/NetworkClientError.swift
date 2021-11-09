public enum NetworkClientError: Error {
    case none
    case unknown
    case json(description: String)
    case server(description: String)
    case dataIsEmpty
    case networkNotFound
    case cancelled
    case cacheNotFound
    case cacheDirectoryNotFound
    case responseCodeIsNot(code: Int)

    public var code: Int {
        switch self {
        case .none: return -1500
        case .unknown: return -1501
        case .json: return -1502
        case .server: return -1503
        case .dataIsEmpty: return -1504
        case .networkNotFound: return -1505
        case .cancelled: return -1506
        case .cacheNotFound: return -1507
        case .cacheDirectoryNotFound: return -1508
        case .responseCodeIsNot: return -1509
        }
    }
}

public func ==(lhs: NetworkClientError, rhs: NetworkClientError) -> Bool {
    return lhs.code == rhs.code
}

public func !=(lhs: NetworkClientError, rhs: NetworkClientError) -> Bool {
    return lhs.code != rhs.code
}
