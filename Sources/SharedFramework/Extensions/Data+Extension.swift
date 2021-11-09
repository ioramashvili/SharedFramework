import Foundation

extension Data {
    func toJson() throws -> Any {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) else {
            throw NetworkClientError.json(description: "can't create json from data")
        }

        return json
    }
}
