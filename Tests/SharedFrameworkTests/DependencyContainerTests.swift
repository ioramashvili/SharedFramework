import XCTest
@testable import SharedFramework

class DependencyContainerTests: XCTestCase {
    private static let dependencies = DependencyContainer.root.register {
        Module { WidgetModule() as WidgetModuleType }
        Module { SampleModule() as SampleModuleType }
        Module("abc") { SampleModule(value: "123") as SampleModuleType }
        Module { SomeClass() as SomeClassType }
        Module { UserSession() as UserSessionReadableServices }
        Module { UserSession() as UserSessionWritableServices }
        Module { UserSession() as UserSessionServices }
    }

    private static let localDependencies = DependencyContainer {
        Module { WidgetModule() as WidgetModuleType }
    }

    @Inject private var userSessionServices: UserSessionServices
    @Inject private var userSessionReadableServices: UserSessionReadableServices
    @Inject private var userSessionWritableServices: UserSessionWritableServices

    @Inject private var widgetModule: WidgetModuleType
    @Inject(from: localDependencies) private var localWidgetModule: WidgetModuleType
    @Inject private var sampleModule: SampleModuleType
    @Inject("abc") private var sampleModule2: SampleModuleType
    @Inject private var someClass: SomeClassType

    private lazy var widgetWorker: WidgetWorkerType = widgetModule.component()
    private lazy var someObject: SomeObjectType = sampleModule.component()
    private lazy var anotherObject: AnotherObjectType = sampleModule.component()
    private lazy var viewModelObject: ViewModelObjectType = sampleModule.component()
    private lazy var viewControllerObject: ViewControllerObjectType = sampleModule.component()

    override class func setUp() {
        super.setUp()
        dependencies.build()
    }
}

// MARK: - Test Cases
extension DependencyContainerTests {

    func testLocalResolver() {
        let localWidgetModuleResult = localWidgetModule.test()
        XCTAssertEqual(localWidgetModuleResult, "WidgetModule.test()")
    }

    func testResolver() {
        let normal = userSessionServices.test()
        let readable = userSessionReadableServices.test()
        let writable = userSessionWritableServices.test()

        XCTAssertEqual(normal, "UserSessionServices.test()")
        XCTAssertEqual(readable, "UserSessionReadableServices.test()")
        XCTAssertEqual(writable, "UserSessionWritableServices.test()")

        // Given
        let widgetModuleResult = widgetModule.test()
        let sampleModuleResult = sampleModule.test()
        let sampleModule2Result = sampleModule2.test()
        let widgetResult = widgetWorker.fetch(id: 3)
        let someResult = someObject.testAbc()
        let anotherResult = anotherObject.testXyz()
        let viewModelResult = viewModelObject.testLmn()
        let viewModelNestedResult = viewModelObject.testLmnNested()
        let viewControllerResult = viewControllerObject.testRst()
        let viewControllerNestedResult = viewControllerObject.testRstNested()

        // Then
        XCTAssertEqual(widgetModuleResult, "WidgetModule.test()")
        XCTAssertEqual(sampleModuleResult, "SampleModule.test()")
        XCTAssertEqual(sampleModule2Result, "SampleModule.test()123")
        XCTAssertEqual(widgetResult, "|MediaRealmStore.3||MediaNetworkRemote.3|")
        XCTAssertEqual(someResult, "SomeObject.testAbc")
        XCTAssertEqual(anotherResult, "AnotherObject.testXyz|SomeObject.testAbc")
        XCTAssertEqual(viewModelResult, "SomeViewModel.testLmn|SomeObject.testAbc")
        XCTAssertEqual(viewModelNestedResult, "SomeViewModel.testLmnNested|AnotherObject.testXyz|SomeObject.testAbc")
        XCTAssertEqual(viewControllerResult, "SomeViewController.testRst|SomeObject.testAbc")
        XCTAssertEqual(viewControllerNestedResult, "SomeViewController.testRstNested|AnotherObject.testXyz|SomeObject.testAbc")
    }
}

public struct UserSession: UserSessionServices {

}

public protocol UserSessionServices: UserSessionReadableServices, UserSessionWritableServices { }
extension UserSessionServices {
    func test() -> String {
        "UserSessionServices.test()"
    }
}

public protocol UserSessionReadableServices { }
extension UserSessionReadableServices {
    func test() -> String {
        "UserSessionReadableServices.test()"
    }
}

public protocol UserSessionWritableServices { }
extension UserSessionWritableServices {
    func test() -> String {
        "UserSessionWritableServices.test()"
    }
}

extension DependencyContainerTests {

    func testNumberOfInstances() {
        let instance1 = someClass
        let instance2 = someClass
        XCTAssertEqual(instance1.id, instance2.id)
    }
}

// MARK: - Subtypes
extension DependencyContainerTests {

    struct WidgetModule: WidgetModuleType {

        func component() -> WidgetWorkerType {
            WidgetWorker(
                store: component(),
                remote: component()
            )
        }

        func component() -> WidgetRemote {
            WidgetNetworkRemote(httpService: component())
        }

        func component() -> WidgetStore {
            WidgetRealmStore()
        }

        func component() -> HTTPServiceType {
            HTTPService()
        }

        func test() -> String {
            "WidgetModule.test()"
        }
    }

    struct SampleModule: SampleModuleType {
        let value: String?

        init(value: String? = nil) {
            self.value = value
        }

        func component() -> SomeObjectType {
            SomeObject()
        }

        func component() -> AnotherObjectType {
            AnotherObject(someObject: component())
        }

        func component() -> ViewModelObjectType {
            SomeViewModel(
                someObject: component(),
                anotherObject: component()
            )
        }

        func component() -> ViewControllerObjectType {
            SomeViewController()
        }

        func test() -> String {
            "SampleModule.test()\(value ?? "")"
        }
    }

    struct SomeObject: SomeObjectType {
        func testAbc() -> String {
            "SomeObject.testAbc"
        }
    }

    class SomeClass: SomeClassType {
        let id: String

        init() {
            self.id = UUID().uuidString
        }
    }

    struct AnotherObject: AnotherObjectType {
        private let someObject: SomeObjectType

        init(someObject: SomeObjectType) {
            self.someObject = someObject
        }

        func testXyz() -> String {
            "AnotherObject.testXyz|" + someObject.testAbc()
        }
    }

    struct SomeViewModel: ViewModelObjectType {
        private let someObject: SomeObjectType
        private let anotherObject: AnotherObjectType

        init(someObject: SomeObjectType, anotherObject: AnotherObjectType) {
            self.someObject = someObject
            self.anotherObject = anotherObject
        }

        func testLmn() -> String {
            "SomeViewModel.testLmn|" + someObject.testAbc()
        }

        func testLmnNested() -> String {
            "SomeViewModel.testLmnNested|" + anotherObject.testXyz()
        }
    }

    class SomeViewController: ViewControllerObjectType {
        @Inject private var module: SampleModuleType

        private lazy var someObject: SomeObjectType = module.component()
        private lazy var anotherObject: AnotherObjectType = module.component()

        func testRst() -> String {
            "SomeViewController.testRst|" + someObject.testAbc()
        }

        func testRstNested() -> String {
            "SomeViewController.testRstNested|" + anotherObject.testXyz()
        }
    }

    struct WidgetWorker: WidgetWorkerType {
        private let store: WidgetStore
        private let remote: WidgetRemote

        init(store: WidgetStore, remote: WidgetRemote) {
            self.store = store
            self.remote = remote
        }

        func fetch(id: Int) -> String {
            store.fetch(id: id)
                + remote.fetch(id: id)
        }
    }

    struct WidgetNetworkRemote: WidgetRemote {
        private let httpService: HTTPServiceType

        init(httpService: HTTPServiceType) {
            self.httpService = httpService
        }

        func fetch(id: Int) -> String {
            "|MediaNetworkRemote.\(id)|"
        }
    }

    struct WidgetRealmStore: WidgetStore {

        func fetch(id: Int) -> String {
            "|MediaRealmStore.\(id)|"
        }

        func createOrUpdate(_ request: String) -> String {
            "MediaRealmStore.createOrUpdate\(request)"
        }
    }

    struct HTTPService: HTTPServiceType {

        func get(url: String) -> String {
            "HTTPService.get"
        }

        func post(url: String) -> String {
            "HTTPService.post"
        }
    }
}

// MARK: API
protocol WidgetModuleType {
    func component() -> WidgetWorkerType
    func component() -> WidgetRemote
    func component() -> WidgetStore
    func component() -> HTTPServiceType
    func test() -> String
}

protocol SampleModuleType {
    func component() -> SomeObjectType
    func component() -> AnotherObjectType
    func component() -> ViewModelObjectType
    func component() -> ViewControllerObjectType
    func test() -> String
}

protocol SomeObjectType {
    func testAbc() -> String
}

protocol SomeClassType {
    var id: String { get }
}

protocol AnotherObjectType {
    func testXyz() -> String
}

protocol ViewModelObjectType {
    func testLmn() -> String
    func testLmnNested() -> String
}

protocol ViewControllerObjectType {
    func testRst() -> String
    func testRstNested() -> String
}

protocol WidgetStore {
    func fetch(id: Int) -> String
    func createOrUpdate(_ request: String) -> String
}

protocol WidgetRemote {
    func fetch(id: Int) -> String
}

protocol WidgetWorkerType {
    func fetch(id: Int) -> String
}

protocol HTTPServiceType {
    func get(url: String) -> String
    func post(url: String) -> String
}
