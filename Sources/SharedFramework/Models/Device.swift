import UIKit

public protocol DeviceDataSourse: AnyObject {
    var fontMultipliers: [Device.ScreenSize: CGFloat] { get }
}

final public class Device {
    public static let shared = Device()
    public weak var dataSourse: DeviceDataSourse?
    
    private init() { }
    
    public var current: (family: Device.Family, name: Device.Name) {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        let currentDeviceName = getDeviceName(for: identifier)
        let currentDeviceFamily = getDeviceFamily(for: currentDeviceName)
        
        return (currentDeviceFamily, currentDeviceName)
    }
    
    private func getDeviceFamily(for name: Device.Name) -> Device.Family {
        if name.rawValue.contains(Device.Family.iPhone.rawValue) { return .iPhone }
        else if name.rawValue.contains(Device.Family.iPad.rawValue) { return .iPad }
        else if name.rawValue.contains(Device.Family.iPod.rawValue) { return .iPod }
        
        return .unknown
    }
    
    private func getDeviceName(for identifier: String) -> Name {
        switch identifier {
        case "iPod5,1":                                        return .iPodTouch5
        case "iPod7,1":                                        return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":            return .iPhone4
        case "iPhone4,1":                                      return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                         return .iPhone5
        case "iPhone5,3", "iPhone5,4":                         return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                         return .iPhone5s
        case "iPhone7,2":                                      return .iPhone6
        case "iPhone7,1":                                      return .iPhone6Plus
        case "iPhone8,1":                                      return .iPhone6s
        case "iPhone8,2":                                      return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                         return .iPhone7
        case "iPhone9,2", "iPhone9,4":                         return .iPhone7Plus
        case "iPhone8,4":                                      return .iPhoneSE
        case "iPhone10,1", "iPhone10,4":                       return .iPhone8
        case "iPhone10,2", "iPhone10,5":                       return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                       return .iPhoneX
        case "iPhone11,2":                                     return .iPhoneXs
        case "iPhone11,4", "iPhone11,6":                       return .iPhoneXsMax
        case "iPhone11,8":                                     return .iPhoneXr
        case "iPhone12,1":                                     return .iPhone11
        case "iPhone12,3":                                     return .iPhone11Pro
        case "iPhone12,5":                                     return .iPhone11ProMax
        case "iPhone12,8":                                     return .iPhoneSE_2
        case "iPhone13,1":                                     return .iPhone12mini
        case "iPhone13,2":                                     return .iPhone12
        case "iPhone13,3":                                     return .iPhone12Pro
        case "iPhone13,4":                                     return .iPhone12ProMax
        case "iPhone14,4":                                     return .iPhone13mini
        case "iPhone14,5":                                     return .iPhone13
        case "iPhone14,2":                                     return .iPhone13Pro
        case "iPhone14,3":                                     return .iPhone13ProMax
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":       return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":                  return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":                  return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":                  return .iPadAir
        case "iPad5,3", "iPad5,4":                             return .iPadAir2
        case "iPad6,11", "iPad6,12":                           return .iPad5
        case "iPad7,5", "iPad7,6":                             return .iPad6
        case "iPad7,11", "iPad7,12":                           return .iPad7
        case "iPad11,6", "iPad11,7":                           return .iPad8
        case "iPad12,1", "iPad12,2":                           return .iPad9
        case "iPad2,5", "iPad2,6", "iPad2,7":                  return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":                  return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":                  return .iPadMini3
        case "iPad5,1", "iPad5,2":                             return .iPadMini4
        case "iPad11,1", "iPad11,2":                           return .iPadMini5
        case "iPad14,1", "iPad14,2":                           return .iPadMini6
        case "iPad6,3", "iPad6,4":                             return .iPadPro9_7
        case "iPad6,7", "iPad6,8":                             return .iPadPro12_9_1
        case "iPad7,1", "iPad7,2":                             return .iPadPro12_9_2
        case "iPad7,3", "iPad7,4":                             return .iPadPro10_5
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":       return .iPadPro11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":       return .iPadPro12_9_3
        case "iPad8,11", "iPad8,12":                           return .iPadPro12_9_4
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .iPadPro12_9_5
        case "AppleTV5,3":                                     return .appleTV
        case "AppleTV6,2":                                     return .appleTV4K
        case "i386", "x86_64":                                 return getDeviceName(for: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "")
        default:                                               return .unknown
        }
    }
    
    public func normalized(fontSize: CGFloat) -> CGFloat {
        guard
            let dataSourse = dataSourse,
            let multiplier = dataSourse.fontMultipliers[Device.shared.current.name.screenSize] else {return fontSize}
        
        return fontSize * multiplier
    }
    
    public func normalized(font: UIFont) -> UIFont {
        let normalizedFontSize = normalized(fontSize: font.pointSize)
        return font.withSize(normalizedFontSize)
    }
}

public extension Device {
    enum Family: String {
        case unknown
        case iPhone
        case iPad
        case iPod
        
        public var isiPad: Bool {
            return self == .iPad
        }
    }
    
    enum ScreenSize {
        case unknown
        case inch4
        case inch4_7
        case inch5_5
        case inchIpad
        
        public static var allNamesByScreenSize: [ScreenSize: [Name]] {
            return [
                .inch4: [
                    .iPhone4,
                    .iPhone4s,
                    .iPhone5,
                    .iPhone5c,
                    .iPhone5s,
                    .iPhoneSE
                ],
                .inch4_7: [
                    .iPhone6,
                    .iPhone6s,
                    .iPhone7,
                    .iPhone8,
                    .iPhoneX,
                    .iPhoneXs,
                    .iPhone11,
                    .iPhoneSE_2
                ],
                .inch5_5: [
                    .iPhone6Plus,
                    .iPhone6sPlus,
                    .iPhone7Plus,
                    .iPhone8Plus,
                    .iPhoneXr,
                    .iPhoneXsMax,
                    .iPhone11,
                    .iPhone11ProMax,
                    .iPhone12mini,
                    .iPhone12,
                    .iPhone12Pro,
                    .iPhone12ProMax,
                    .iPhone13mini,
                    .iPhone13,
                    .iPhone13Pro,
                    .iPhone13ProMax
                ],
                .inchIpad: [
                    .appleTV,
                    .iPad2,
                    .iPad3,
                    .iPad4,
                    .iPadAir,
                    .iPadAir2,
                    .iPad5,
                    .iPad6,
                    .iPad7,
                    .iPad8,
                    .iPad9,
                    .iPadMini,
                    .iPadMini2,
                    .iPadMini3,
                    .iPadMini4,
                    .iPadMini5,
                    .iPadMini6,
                    .iPadPro9_7,
                    .iPadPro12_9_1,
                    .iPadPro12_9_2,
                    .iPadPro10_5,
                    .iPadPro11,
                    .iPadPro12_9_3,
                    .iPadPro12_9_4
                ]
            ]
        }
        
        public var names: [Name] {
            return ScreenSize.allNamesByScreenSize[self] ?? []
        }
    }
    
    enum Name: String {
        case unknown
        case iPhone4
        case iPhone4s
        case iPhone5
        case iPhone5c
        case iPhone5s
        case iPhone6
        case iPhone6Plus
        case iPhone6s
        case iPhone6sPlus
        case iPhone7
        case iPhone7Plus
        case iPhoneSE
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXs
        case iPhoneXsMax
        case iPhoneXr
        case iPhone11
        case iPhone11Pro
        case iPhone11ProMax
        case iPhoneSE_2
        case iPhone12mini
        case iPhone12
        case iPhone12Pro
        case iPhone12ProMax
        case iPhone13mini
        case iPhone13
        case iPhone13Pro
        case iPhone13ProMax
        
        case iPodTouch5
        case iPodTouch6
        
        case iPad2
        case iPad3
        case iPad4
        case iPadAir
        case iPadAir2
        case iPad5
        case iPad6
        case iPad7
        case iPad8
        case iPad9
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadMini5
        case iPadMini6
        case iPadPro9_7
        case iPadPro12_9_1
        case iPadPro12_9_2
        case iPadPro10_5
        case iPadPro11
        case iPadPro12_9_3
        case iPadPro12_9_4
        case iPadPro12_9_5
        
        case appleTV
        case appleTV4K
        
        case simulator
        
        public var isHugeiPad: Bool {
            let iPads: [Device.Name] = [.iPadPro12_9_1, .iPadPro12_9_2, .iPadPro12_9_3, .iPadPro12_9_4, .iPadPro12_9_5]
            return iPads.contains(self)
        }
        
        public var screenSize: ScreenSize {
            return ScreenSize.allNamesByScreenSize.first(where: { $0.value.contains(self) })?.key ?? .unknown
        }
        
        public func names(by family: Family) -> [Name] {
            switch family {
            case .iPhone:
                return [
                    .iPhone4,
                    .iPhone4s,
                    .iPhone5,
                    .iPhone5c,
                    .iPhone5s,
                    .iPhone6,
                    .iPhone6Plus,
                    .iPhone6s,
                    .iPhone6sPlus,
                    .iPhone7,
                    .iPhone7Plus,
                    .iPhoneSE,
                    .iPhone8,
                    .iPhone8Plus,
                    .iPhoneX,
                    .iPhoneXr,
                    .iPhoneXs,
                    .iPhoneXsMax,
                    .iPhone11,
                    .iPhone11Pro,
                    .iPhone11ProMax
                ]
            case .iPod:
                return [
                    .iPodTouch5,
                    .iPodTouch6
                ]
            case .iPad:
                return [
                    .iPad2,
                    .iPad3,
                    .iPad4,
                    .iPadAir,
                    .iPadAir2,
                    .iPad5,
                    .iPad6,
                    .iPadMini,
                    .iPadMini2,
                    .iPadMini3,
                    .iPadMini4,
                    .iPadMini5,
                    .iPadMini6,
                    .iPadPro9_7,
                    .iPadPro12_9_1,
                    .iPadPro12_9_2,
                    .iPadPro10_5,
                    .iPadPro11,
                    .iPadPro12_9_3,
                    .iPadPro12_9_4,
                    .iPadPro12_9_5
                ]
            case .unknown:
                return [
                    .appleTV,
                    .simulator
                ]
            }
        }
    }
}
