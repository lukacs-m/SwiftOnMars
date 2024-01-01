//
//  RoverEntity.swift
//
//
//  Created by Martin Lukacs on 26/12/2023.
//

import Foundation
import SwiftData

@Model
public final class RoverEntity: Identifiable, Equatable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let landingDate: String
    public let launchDate: String
    public let status: String
    public let maxSol: Int?
    public let maxDate: String?
    public let totalPhotos: Int?
    public let cameras: [LightCameraEntity]?

    public init(id: Int, name: String, landingDate: String, launchDate: String, status: String, maxSol: Int?, maxDate: String?,
                totalPhotos: Int?, cameras: [LightCameraEntity]?) {
        self.id = id
        self.name = name
        self.landingDate = landingDate
        self.launchDate = launchDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.totalPhotos = totalPhotos
        self.cameras = cameras
    }
}

public struct LightCameraEntity: Codable, Identifiable, Equatable, Hashable, Sendable {
    public var id: String {
        name
    }

    public let name: String
    public let fullName: String

    public init(name: String, fullName: String) {
        self.name = name
        self.fullName = fullName
    }

    enum CodingKeys: String, CodingKey {
        case name
        case fullName
    }
}
