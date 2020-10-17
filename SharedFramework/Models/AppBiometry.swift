import LocalAuthentication

final public class AppBiometry {
    public typealias SuccessComplition = () -> Void
    public typealias ErrorComplition = (_ error: Error?) -> Void

    public static let shared = AppBiometry()
    public weak var dataSourse: AppBiometryDataSourse!
    private let context = LAContext()

    private init() { }

    public var isAvailable: Bool {
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {return true}

        guard let laError = error as? LAError else {return false}

        return laError.code != .biometryNotAvailable
    }

    public var biometryType: LABiometryType {
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return context.biometryType
        }

        return .none
    }

    public func authenticate(successComplition: @escaping SuccessComplition, errorComplition: @escaping ErrorComplition) {
        var error: NSError?
        let reasonString = dataSourse.reasonStrings[biometryType] ?? "please provide text"

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            errorComplition(error)
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, evalPolicyError) in
            DispatchQueue.main.async {
                if success {
                    successComplition()
                } else {
                    errorComplition(evalPolicyError)
                }
            }
        })
    }
}
