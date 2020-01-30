
public extension Optional where Wrapped: Any {
    var dynamicWrappedType : Wrapped.Type {
        return Wrapped.self
    }
    
    var boolValue: Bool? {
        return try? self.to(Bool.self)
    }
    
    var stringValue: String? {
        return try? self.to(String.self)
    }
    
    var doubleValue: Double? {
        return try? self.to(Double.self)
    }
    
    var intValue: Int? {
        return try? self.to(Int.self)
    }
    
    var characterValue: Character? {
        return try? self.to(Character.self)
    }
}

public extension Optional where Wrapped: Any {
    @discardableResult
    func to<T>(_ type: T.Type) throws -> T {
        guard let value = self as? T else {
            throw OptionalCastError.cast(onType: T.self)
        }
        
        return value
    }
    
    @discardableResult
    func toWrappedType() throws -> Wrapped {
        return try to(dynamicWrappedType)
    }
}

public enum OptionalCastError<T>: Error {
    case cast(onType: T)
}
