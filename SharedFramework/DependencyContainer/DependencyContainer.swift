import Foundation

public class DependencyContainer {
    private var modules: [String: Module] = [:]
    
    private init() {}
    deinit { modules.removeAll() }
}

internal extension DependencyContainer {
    func add(module: Module) {
        modules[module.name] = module
    }
    
    func resolve<T>(for name: String? = nil) -> T {
        let name = name ?? String(describing: T.self)
        
        guard let component: T = modules[name]?.resolve() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}

public extension DependencyContainer {
    static var root = DependencyContainer()
    
    convenience init(@ModuleBuilder _ modules: () -> [Module]) {
        self.init()
        modules().forEach { add(module: $0) }
    }
    
    convenience init(@ModuleBuilder _ module: () -> Module) {
        self.init()
        add(module: module())
    }
    
    func register(@ModuleBuilder _ modules: () -> [Module]) -> Self {
        modules().forEach { add(module: $0) }
        return self
    }
    
    func build() {
        _ = Self.root
    }
    
    @_functionBuilder struct ModuleBuilder {
        public static func buildBlock(_ modules: Module...) -> [Module] { modules }
        public static func buildBlock(_ module: Module) -> Module { module }
    }
}
