//
//  PhotoEntity.swift
//
//
//  Created by Martin Lukacs on 25/12/2023.
//

import Foundation
import NasaModels
import SwiftData

@Model
public final class PhotoEntity: Equatable, Hashable, Sendable {
    @Attribute(.unique) public let id: Int
    public let sol: Int
    public let camera: CameraEntity
    public let imgSrc: String
    public let earthDate: String
    public let rover: RoverEntity

    public init(id: Int, sol: Int, camera: CameraEntity, imgSrc: String, earthDate: String, rover: RoverEntity) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.imgSrc = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }
}
