//
//  RoverIdentification.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

public enum RoverIdentification: String, Sendable, Codable {
    case curiosity
    case perseverance
    case opportunity
    case spirit

    public static func value(for nameDescription: String) -> RoverIdentification {
        switch nameDescription {
        case curiosity.rawValue:
            .curiosity
        case perseverance.rawValue:
            .perseverance
        case opportunity.rawValue:
            .opportunity
        case spirit.rawValue:
            .spirit
        default:
            .curiosity
        }
    }
}
