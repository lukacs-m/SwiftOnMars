//
//  Photo.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

// MARK: - Photos
public struct Photos: Codable, Sendable {
    public let photos: [Photo]
}

// MARK: - Photo
public struct Photo: Codable, Identifiable, Equatable, Hashable, Sendable {
    public let id, sol: Int
    public let camera: Camera
    public let imgSrc: String
    public let earthDate: String
    public let rover: Rover

    public init(id: Int, sol: Int, camera: Camera, imgSrc: String, earthDate: String, rover: Rover) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.imgSrc = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
