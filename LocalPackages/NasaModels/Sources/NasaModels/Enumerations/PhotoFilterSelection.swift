//
//  PhotoFilterSelection.swift
//
//
//  Created by Martin Lukacs on 22/05/2023.
//

import Foundation

public enum PhotoFilterSelection: CaseIterable, Sendable, Equatable, Hashable {
    case defaultFilter
    case camera
    case rover
    case sol

    public var title: String {
        switch self {
        case .defaultFilter:
            "Default"
        case .camera:
            "Camera"
        case .rover:
            "Rover"
        case .sol:
            "Sol"
        }
    }
}
