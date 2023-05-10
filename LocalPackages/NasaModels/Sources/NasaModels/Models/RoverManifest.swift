//
//  RoverManifest.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

import Foundation

// MARK: - RoverManifest
public struct RoverManifest: Codable, Sendable {
    public let photoManifest: PhotoManifest

    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}

// MARK: - PhotoManifest
public struct PhotoManifest: Codable, Sendable, Identifiable, Equatable, Hashable {
    public var id: String {
        name
    }

    public let name, landingDate, launchDate, status: String
    public let maxSol: Int
    public let maxDate: String
    public let totalPhotos: Int
    public let photos: [PhotoInformation]

    enum CodingKeys: String, CodingKey {
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case photos
    }
}

// MARK: - Photo
public struct PhotoInformation: Codable, Sendable, Identifiable, Equatable, Hashable {
    public var id: Int {
        sol
    }
    
    public let sol: Int
    public let earthDate: String
    public let totalPhotos: Int
    public let cameras: [String]

    enum CodingKeys: String, CodingKey {
        case sol
        case earthDate = "earth_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}
