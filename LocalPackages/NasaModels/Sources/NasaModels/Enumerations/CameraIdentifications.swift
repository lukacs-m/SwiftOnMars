//
//  CameraIdentifications.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation

public enum CameraIdentifications: CaseIterable {
    case fhaz // Front Hazard Avoidance Camera
    case rhaz // Rear Hazard Avoidance Camera
    case mast // Mast Camera
    case chemcam // Chemistry and Camera Complex
    case mahli // Mars Hand Lens Imager
    case mardi // Mars Descent Imager
    case navcam // Navigation Camera
    case pancam // Panoramic Camera
    case minites // Miniature Thermal Emission Spectrometer (Mini-TES)

    static public func accesibleCameras(for rover: RoverIdentification) -> [CameraIdentifications] {
        switch rover {
        case .curiosity:
            return [.fhaz, .rhaz,  .mast, .chemcam, .mahli, .mardi, .navcam]
        case .opportunity, .spirit:
            return [.fhaz, .rhaz, .navcam, .pancam, .minites]
        }
    }
}
