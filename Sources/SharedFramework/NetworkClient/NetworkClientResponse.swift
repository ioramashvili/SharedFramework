import UIKit

open class NetworkClientResponse<T> {
    public let serverRequest: NetworkClientRequest
    public let data: Data?
    public let output: T?
    public let savedToCache: Bool
    public let errorCode: Error

    public init(serverRequest: NetworkClientRequest, data: Data?, output: T?, savedToCache: Bool, errorCode: Error = NetworkClientError.none) {
        self.serverRequest = serverRequest
        self.data = data
        self.output = output
        self.savedToCache = savedToCache
        self.errorCode = errorCode
    }

    public convenience init(serverRequest: NetworkClientRequest, errorCode: Error) {
        self.init(serverRequest: serverRequest, data: nil, output: nil, savedToCache: false, errorCode: errorCode)
    }
}
