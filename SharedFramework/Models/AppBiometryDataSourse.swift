import LocalAuthentication

public protocol AppBiometryDataSourse: class {
    var reasonStrings: [LABiometryType: String] { get }
}
