
extension Error {
    public var errorCode: NetworkClientError {
        guard let urlError = self as? URLError else { return .unknown }
        
        switch urlError.code {
        case .notConnectedToInternet, .networkConnectionLost: return .networkNotFound
        case .cancelled: return .cancelled
        default: return .unknown
        }
    }
}
