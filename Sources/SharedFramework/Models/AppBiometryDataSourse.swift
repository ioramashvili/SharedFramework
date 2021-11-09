import LocalAuthentication

public protocol AppBiometryDataSourse: AnyObject {
    var reasonStrings: [LABiometryType: String] { get }
}
