
public typealias JSONParam = [String: Any]
public typealias HeaderValues = [String: String]

open class NetworkClientRequest {
    public let httpMethod: HttpMethod
    public let method: Methodable
    
    fileprivate var _headerValues: HeaderValues
    fileprivate var _param: JSONParam
    fileprivate var _decoder: JSONDecoder
    fileprivate var _responseDataCachingEnabled: Bool
    fileprivate var _cacheFileName: String
    
    public init(
        httpMethod: HttpMethod,
        method: Methodable,
        param: JSONParam = [:],
        headerValues: HeaderValues = [:],
        responseDataCachingEnabled: Bool = false,
        cacheFileName: String? = nil) {
        
        self.httpMethod = httpMethod
        self.method = method
        self._param = param
        self._headerValues = headerValues
        self._decoder = JSONDecoder()
        self._responseDataCachingEnabled = responseDataCachingEnabled
        self._cacheFileName = cacheFileName ?? "\(method.number).txt"
    }
    
    open var param: JSONParam {
        return _param
    }
    
    open var headerValues: HeaderValues {
        return _headerValues
    }
    
    open var decoder: JSONDecoder {
        return _decoder
    }
    
    open func set(param: JSONParam) -> NetworkClientRequest {
        self._param = param
        return self
    }
    
    open func set(headerValues: HeaderValues) -> NetworkClientRequest {
        self._headerValues = headerValues
        return self
    }
    
    open func set(decoder: JSONDecoder) -> NetworkClientRequest {
        self._decoder = decoder
        return self
    }
    
    @discardableResult
    open func cacheResponseData() -> NetworkClientRequest {
        _responseDataCachingEnabled = true
        return self
    }
    
    @discardableResult
    open func set(cacheResponseDataFileName fileName: String) -> NetworkClientRequest {
        cacheResponseData()
        _cacheFileName = "\(fileName).txt"
        return self
    }
    
    open var responseDataCachingEnabled: Bool {
        return _responseDataCachingEnabled
    }
    
    open var httpBody: Data? {
        switch httpMethod {
        case .post: return try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
        default: return nil
        }
    }
    
    public var httpMethodName: String {
        return httpMethod.name
    }
    
    open var requestUrl: URL {
        return httpMethod == .get ? queryUrl : method.requestUrl
    }
    
    open var cacheFileName: String {
        return _cacheFileName
    }
    
    fileprivate var queryUrl: URL {
        var urlComponents = URLComponents(url: method.requestUrl, resolvingAgainstBaseURL: false)
        
        let queryItems = param.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents!.url!
    }
    
    fileprivate func createRequest() -> URLRequest {
        var request = URLRequest(url: requestUrl)
        request.httpMethod = httpMethodName
        request.httpBody = httpBody
        
        return request
    }
    
    public enum HttpMethod: String {
        case none, get, post
        
        var name: String {
            return rawValue
        }
    }
    
    @discardableResult
    internal func trySave(data: Data?, as fileName: String) -> Bool {
        guard let data = data, responseDataCachingEnabled else {return false}
        
        do {
            let path = try method.getCachePath(for: fileName)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        }
        catch {
            return false
        }
        
        return true
    }
    
    internal func read(from fileName: String) throws -> Data {
        do {
            let path = try method.getCachePath(for: fileName)
            return try Data(contentsOf: path)
        } catch {
            throw NetworkClientError.cacheNotFound
        }
    }

    fileprivate func getRequest() -> URLRequest {
        var request = createRequest()
        request.setHeader(values: headerValues)
        request.setHeader(values: method.headerValues)
        
        return request
    }
    
    fileprivate func getSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }
    
    @discardableResult
    open func startWithExpectedJson(complition: @escaping (_ response: NetworkClientResponse<Any>) -> Void) -> URLSessionDataTask {
        return start(parsingJson: true, complition: complition)
    }
    
    @discardableResult
    open func start(complition: @escaping (_ response: NetworkClientResponse<Any>) -> Void) -> URLSessionDataTask {
        return start(parsingJson: false, complition: complition)
    }
    
    @discardableResult
    open func start(parsingJson: Bool, complition: @escaping (_ response: NetworkClientResponse<Any>) -> Void) -> URLSessionDataTask {
        let request = getRequest()
        let session = getSession()
        
        let task = session.dataTask(with: request) { data, response, error in
            var errorCode: Error = NetworkClientError.none
            
            do {
                try response?.isStatus(code: 200)
                var json: Any? = nil
                
                if parsingJson {
                    guard let _ = data else { throw NetworkClientError.dataIsEmpty }
                    json = try data?.toJson()
                }
                
                let savedToCache = self.trySave(data: data, as: self.cacheFileName)
                
                DispatchQueue.main.async {
                    complition(NetworkClientResponse<Any>(serverRequest: self, data: data, output: json, savedToCache: savedToCache))
                }
                
                return
            } catch {
                errorCode = error
            }
            
            DispatchQueue.main.async {
                complition(NetworkClientResponse<Any>(serverRequest: self, errorCode: error?.errorCode ?? errorCode))
            }
        }
        
        task.resume()
        
        return task
    }
    
    @discardableResult
    open func startWithExpected<T>(type: T.Type, complition: @escaping (_ response: NetworkClientResponse<T>) -> Void) -> URLSessionDataTask where T : Decodable {
        
        let request = getRequest()
        let session = getSession()
        
        let task = session.dataTask(with: request) { data, response, error in
            var errorCode: Error = NetworkClientError.none
            
            do {
                try response?.isStatus(code: 200)
                
                guard let data = data else { throw NetworkClientError.dataIsEmpty }
                
                let output = try self.decoder.decode(T.self, from: data)
                
                let savedToCache = self.trySave(data: data, as: self.cacheFileName)
                
                let successResponse = NetworkClientResponse<T>(serverRequest: self, data: data, output: output, savedToCache: savedToCache)
                
                DispatchQueue.main.async {
                    complition(successResponse)
                }
                
                return
            } catch {
                errorCode = error
            }
            
            let errorResponse = NetworkClientResponse<T>(serverRequest: self, errorCode: error?.errorCode ?? errorCode)
            
            DispatchQueue.main.async {
                complition(errorResponse)
            }
        }
        
        task.resume()
        
        return task
    }
}


