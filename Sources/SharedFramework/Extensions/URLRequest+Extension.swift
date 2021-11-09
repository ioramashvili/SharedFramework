import Foundation

extension URLRequest {
    mutating func setHeader(values: HeaderValues?) {
        values?.forEach {
            addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
