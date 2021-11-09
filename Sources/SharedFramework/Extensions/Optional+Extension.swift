public extension Optional where Wrapped: Any {
    var dynamicWrappedType: Wrapped.Type {
        Wrapped.self
    }

    var boolValue: Bool? {
        try? self.to(Bool.self)
    }

    var stringValue: String? {
        try? self.to(String.self)
    }

    var doubleValue: Double? {
        try? self.to(Double.self)
    }

    var intValue: Int? {
        try? self.to(Int.self)
    }

    var characterValue: Character? {
        try? self.to(Character.self)
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
        try to(dynamicWrappedType)
    }
}

public enum OptionalCastError<T>: Error {
    case cast(onType: T)
}
