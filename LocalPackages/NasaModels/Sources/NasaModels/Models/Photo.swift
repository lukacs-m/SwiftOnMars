//
//  Photo.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

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

    public var imageUrl: URL? {
        let url = imgSrc.contains("https:") ? imgSrc : imgSrc.replacingOccurrences(of: "http:", with: "https:")
        return URL(string: url)
    }
}

extension Photo: Mockable {
    public static var mocked: Photo {
        Photo(id: 10,
              sol: 1_200,
              camera: Camera.mocked,
              imgSrc: "https://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00000/opgs/edr/fcam/FRA_397502305EDR_D0010000AUT_04096M_.JPG",
              earthDate: "2004-02-03",
              rover: Rover.mocked)
    }
}
