import Foundation

@propertyWrapper
public class Inject<Value> {
    public let name: String?
    public var storage: Value?
    public var dependencies: DependencyContainer?

    public var wrappedValue: Value {
        storage ?? {
            let value: Value = (dependencies ?? DependencyContainer.root).resolve(for: name)
            storage = value
            return value
        }()
    }

    public init() {
        self.name = nil
    }

    public init(_ name: String) {
        self.name = name
    }

    public init(_ name: String, dependencies: DependencyContainer) {
        self.name = name
        self.dependencies = dependencies
    }

    public init(from dependencies: DependencyContainer) {
        self.name = nil
        self.dependencies = dependencies
    }
}
