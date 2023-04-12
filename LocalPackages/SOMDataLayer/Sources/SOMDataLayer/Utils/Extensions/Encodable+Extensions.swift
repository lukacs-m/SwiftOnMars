//
//  Encodable+Extensions.swift
//  
//
//  Created by Martin Lukacs on 11/04/2023.
//

import Foundation

extension Encodable {
    /// implement convert Struct or Class to Dictionary
    var convertToDictionary: [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return nil
        }

        return dict
    }
}
