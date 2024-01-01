//
//  CameraEntity.swift
//
//
//  Created by Martin Lukacs on 26/12/2023.
//

import Foundation
import SwiftData

@Model
public final class CameraEntity: Identifiable, Equatable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let roverID: Int
    public let fullName: String

    public init(id: Int, name: String, roverID: Int, fullName: String) {
        self.id = id
        self.name = name
        self.roverID = roverID
        self.fullName = fullName
    }
}
