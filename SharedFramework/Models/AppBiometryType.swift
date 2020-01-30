import LocalAuthentication

extension AppBiometry {
    public enum BiometryType {
        case none, touchId, faceId
        
        @available(iOS 11.0, *)
        init(biometryType: LABiometryType) {
            switch biometryType {
            case .none: self = .none
            case .touchID: self = .touchId
            case .faceID: self = .faceId
            @unknown default: self = .none
            }
        }
    }
}
