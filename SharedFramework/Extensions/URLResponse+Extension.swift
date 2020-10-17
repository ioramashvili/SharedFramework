public extension URLResponse {
    func isStatus(code: Int) throws {
        if let statusCode = (self as? HTTPURLResponse)?.statusCode, statusCode != code {
            throw NetworkClientError.responseCodeIsNot(code: code)
        }
    }
}
