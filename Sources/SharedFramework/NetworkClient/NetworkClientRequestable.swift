public protocol NetworkClientRequestable: AnyObject {
    init(method: Methodable, param: JSONParam, headerValues: HeaderValues)
    init(method: Methodable, param: JSONParam)
    init(method: Methodable)
}
