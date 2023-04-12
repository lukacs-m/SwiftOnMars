//
//  Rover.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

// MARK: - Rover
public struct Rover: Codable, Identifiable, Equatable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let landingDate: String
    public let launchDate: String
    public let status: String
    public let maxSol: Int?
    public let maxDate: String?
    public let totalPhotos: Int?
    public let cameras: [LightCamera]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

