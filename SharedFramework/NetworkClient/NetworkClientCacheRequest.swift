
open class NetworkClientCacheRequest: NetworkClientRequest {
    public init(method: Methodable) {
        super.init(httpMethod: .none, method: method, param: [:], headerValues: [:], responseDataCachingEnabled: true)
    }
    
    open func from(fileName: String) -> NetworkClientCacheRequest {
        set(cacheResponseDataFileName: fileName)
        return self
    }
}

extension NetworkClientCacheRequest {
    public func withExpected<T>(
        type: T.Type,
        on queue: DispatchQueue,
        complition: @escaping (_ response: NetworkClientResponse<T>) -> Void) where T : Decodable {
        
        queue.async {
            var errorCode: Error = NetworkClientError.none
            
            do {
                let data = try self.read(from: self.cacheFileName)
                
                let output = try self.decoder.decode(T.self, from: data)
                
                let successResponse = NetworkClientResponse<T>(serverRequest: self, data: data, output: output, savedToCache: true)
                
                DispatchQueue.main.async {
                    complition(successResponse)
                }
                
                return
            } catch {
                errorCode = error
            }
            
            let errorResponse = NetworkClientResponse<T>(serverRequest: self, errorCode: errorCode)
            
            DispatchQueue.main.async {
                complition(errorResponse)
            }
        }
    }
    
    public func withExpected<T>(
        type: T.Type,
        complition: @escaping (_ response: NetworkClientResponse<T>) -> Void) where T : Decodable {
        withExpected(type: type, on: DispatchQueue.global(qos: .userInitiated), complition: complition)
    }
}
