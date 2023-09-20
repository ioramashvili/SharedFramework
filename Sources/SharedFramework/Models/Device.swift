import UIKit

final public class Device {
    public static let shared = Device()

    private init() { }
    
    public var current: Device.Name {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return getDeviceName(for: identifier)
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
        case "iPhone14,7":                                     return .iPhone14
        case "iPhone14,8":                                     return .iPhone14Plus
        case "iPhone15,2":                                     return .iPhone14Pro
        case "iPhone15,3":                                     return .iPhone14ProMax
        case "iPhone14,6":                                     return .iPhoneSE_3
        case "iPhone15,4":                                     return .iPhone15
        case "iPhone15,5":                                     return .iPhone15Plus
        case "iPhone16,1":                                     return .iPhone15Pro
        case "iPhone16,2":                                     return .iPhone15ProMax
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
        case "iPad8,9", "iPad8,10":                            return .iPadPro112
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":   return .iPadPro113
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":       return .iPadPro12_9_3
        case "iPad8,11", "iPad8,12":                           return .iPadPro12_9_4
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .iPadPro12_9_5
        case "iPad14,5", "iPad14,6":                           return .iPadPro12_9_6
        case "AppleTV5,3":                                     return .appleTV
        case "AppleTV6,2":                                     return .appleTV4K
        case "i386", "x86_64":                                 return getDeviceName(for: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "")
        default:                                               return .unknown
        }
    }
}

public extension Device {
    enum Name: String {
        case unknown
        case iPhone4        = "iPhone 4"
        case iPhone4s       = "iPhone 4s"
        case iPhone5        = "iPhone 5"
        case iPhone5c       = "iPhone 5c"
        case iPhone5s       = "iPhone 5s"
        case iPhone6        = "iPhone 6"
        case iPhone6Plus    = "iPhone 6 Plus"
        case iPhone6s       = "iPhone 6s"
        case iPhone6sPlus   = "iPhone 6s Plus"
        case iPhone7        = "iPhone 7"
        case iPhone7Plus    = "iPhone 7 Plus"
        case iPhone8        = "iPhone 8"
        case iPhone8Plus    = "iPhone 8 Plus"
        case iPhoneX        = "iPhone X"
        case iPhoneXs       = "iPhone XS"
        case iPhoneXsMax    = "iPhone XS Plus"
        case iPhoneXr       = "iPhone XR"
        case iPhone11       = "iPhone 11"
        case iPhone11Pro    = "iPhone 11 Pro"
        case iPhone11ProMax = "iPhone 11 Pro Max"
        case iPhone12mini   = "iPhone 12 mini"
        case iPhone12       = "iPhone 12"
        case iPhone12Pro    = "iPhone 12 Pro"
        case iPhone12ProMax = "iPhone 12 Pro Max"
        case iPhone13mini   = "iPhone 13 mini"
        case iPhone13       = "iPhone 13"
        case iPhone13Pro    = "iPhone 13 Pro"
        case iPhone13ProMax = "iPhone 13 Pro Max"
        case iPhone14       = "iPhone 14"
        case iPhone14Plus   = "iPhone 14 Plus"
        case iPhone14Pro    = "iPhone 14 Pro"
        case iPhone14ProMax = "iPhone 14 Pro Max"
        case iPhone15       = "iPhone 15"
        case iPhone15Plus   = "iPhone 15 Plus"
        case iPhone15Pro    = "iPhone 15 Pro"
        case iPhone15ProMax = "iPhone 15 Pro Max"
        
        case iPhoneSE       = "iPhone SE"
        case iPhoneSE_2     = "iPhone SE (2nd generation)"
        case iPhoneSE_3     = "iPhone SE (3rd generation)"
        
        case iPodTouch5     = "iPod touch (5th generation)"
        case iPodTouch6     = "iPod touch (6th generation)"
        
        case iPad2          = "iPad 2"
        case iPad3          = "iPad (3rd generation)"
        case iPad4          = "iPad (4th generation)"
        case iPad5          = "iPad (5th generation)"
        case iPad6          = "iPad (6th generation)"
        case iPad7          = "iPad (7th generation)"
        case iPad8          = "iPad (8th generation)"
        case iPad9          = "iPad (9th generation)"
        case iPadAir        = "iPad Air"
        case iPadAir2       = "iPad Air 2"
        case iPadMini       = "iPad mini"
        case iPadMini2      = "iPad mini 2"
        case iPadMini3      = "iPad mini 3"
        case iPadMini4      = "iPad mini 4"
        case iPadMini5      = "iPad mini 5"
        case iPadMini6      = "iPad mini 6"
        case iPadPro9_7     = "iPad Pro (9.7-inch)"
        case iPadPro10_5    = "iPad Pro (10.5-inch)"
        case iPadPro11      = "iPad Pro (11-inch) (1st generation)"
        case iPadPro112     = "iPad Pro (11-inch) (2nd generation)"
        case iPadPro113     = "iPad Pro (11-inch) (3rd generation)"
        case iPadPro12_9_1  = "iPad Pro (12.9-inch) (1st generation)"
        case iPadPro12_9_2  = "iPad Pro (12.9-inch) (2nd generation)"
        case iPadPro12_9_3  = "iPad Pro (12.9-inch) (3rd generation)"
        case iPadPro12_9_4  = "iPad Pro (12.9-inch) (4th generation)"
        case iPadPro12_9_5  = "iPad Pro (12.9-inch) (5th generation)"
        case iPadPro12_9_6  = "iPad Pro (12.9-inch) (6th generation)"
        
        case appleTV        = "Apple TV"
        case appleTV4K      = "Apple TV 4K"
        
        case simulator
    }
}
