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
        
        return laError.code != .touchIDNotAvailable
    }
    
    public var biometryType: BiometryType {
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            guard let laError = error as? LAError else {return .none}
            
            return laError.code != .touchIDNotAvailable ? .touchId : .none
        }
        
        if #available(iOS 11.0, *) {
            return BiometryType(biometryType: context.biometryType)
        }
        
        return .touchId
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

