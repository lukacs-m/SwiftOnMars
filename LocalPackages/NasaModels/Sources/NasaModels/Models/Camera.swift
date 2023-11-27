//
//  Camera.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

// MARK: - Camera

public struct Camera: Codable, Identifiable, Equatable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let roverID: Int
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

// MARK: - Light Camera

public struct LightCamera: Codable, Identifiable, Equatable, Hashable, Sendable {
    public var id: String {
        name
    }

    public let name: String
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

extension Camera: Mockable {
    public static var mocked: Camera {
        Camera(id: 1, name: "test Camera", roverID: 13, fullName: "NAVCAM")
    }
}
