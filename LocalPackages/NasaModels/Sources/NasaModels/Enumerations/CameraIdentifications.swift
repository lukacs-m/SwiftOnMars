//
//  CameraIdentifications.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

public enum CameraIdentifications: String, Codable, CaseIterable, Sendable {
    case fhaz = "FHAZ"// Front Hazard Avoidance Camera
    case rhaz = "RHAZ"// Rear Hazard Avoidance Camera
    case mast = "MAST" // Mast Camera
    case chemcam = "CHEMCAM"// Chemistry and Camera Complex
    case mahli = "MAHLI"// Mars Hand Lens Imager
    case mardi = "MARDI"// Mars Descent Imager
    case navcam = "NAVCAM" // Navigation Camera
    case pancam = "PANCAM" // Panoramic Camera
    case minites = "MINITES"// Miniature Thermal Emission Spectrometer (Mini-TES)

    static public func accesibleCameras(for rover: RoverIdentification) -> [CameraIdentifications] {
        switch rover {
        case .curiosity, .perseverance:
            return [.fhaz, .rhaz,  .mast, .chemcam, .mahli, .mardi, .navcam]
        case .opportunity, .spirit:
            return [.fhaz, .rhaz, .navcam, .pancam, .minites]
        }
    }
}
