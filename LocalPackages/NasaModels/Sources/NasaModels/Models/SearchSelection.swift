//
//  SearchSelection.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

import Foundation

public struct SearchParameters: Codable, Sendable {
    public let roverId: RoverIdentification
    public let sol: Int
    public let earthDate: Date?
    public let searchBySol: Bool
    public let camera: String?

    public init(roverId: RoverIdentification,
                sol: Int = 0,
                earthDate: Date? = nil,
                searchBySol: Bool = true,
                camera: String? = nil) {
        self.roverId = roverId
        self.sol = sol
        self.earthDate = earthDate
        self.searchBySol = searchBySol
        self.camera = camera
    }

    public static var `default`: SearchParameters {
        SearchParameters(roverId: .curiosity, sol: 0, searchBySol: true)
    }
}
