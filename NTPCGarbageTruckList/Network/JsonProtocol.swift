//
//  JsonProtocol.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import Foundation

protocol JsonProtocol {
    static func decocdJson(data: Data?) -> Self?
}

extension JsonProtocol where Self: Codable {
    static func decocdJson(data: Data?) -> Self? {
        guard let jsonData = data else { return nil }

        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            return try decoder.decode(self, from: jsonData)
        } catch {
            print("Convert to \(type(of: self)) error, " + error.localizedDescription)
            let originalData = String(data: jsonData, encoding: .utf8) ?? "(data cannot to UTF8 String)"
            print("Original data: \n" + originalData)
            assert(false)
        }
        return nil
    }
}

extension Data {
    func decodeToModelArray<T>() -> [T]? where T: Codable, T: JsonProtocol {
        do {
            return try JSONDecoder().decode([T].self, from: self)
        } catch {
            print("Error trying to convert data to JSON")
            print(error.localizedDescription)
            assert(false)
        }
        return nil
    }
}
