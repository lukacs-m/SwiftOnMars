//
//  Entities+Extensions.swift
//
//
//  Created by Martin Lukacs on 25/12/2023.
//

import Foundation

import NasaModels

extension Photo {
    var toEntity: PhotoEntity {
        PhotoEntity(id: id,
                    sol: sol,
                    camera: camera.toEntity,
                    imgSrc: imgSrc,
                    earthDate: earthDate,
                    rover: rover.toEntity)
    }
}

extension PhotoEntity {
    var toPhoto: Photo {
        Photo(id: id,
              sol: sol,
              camera: camera.toCamera,
              imgSrc: imgSrc,
              earthDate: earthDate,
              rover: rover.toRover)
    }
}

extension [PhotoEntity] {
    var toPhotos: [Photo] {
        map(\.toPhoto)
    }
}

extension Camera {
    var toEntity: CameraEntity {
        CameraEntity(id: id, name: name, roverID: roverID, fullName: fullName)
    }
}

extension CameraEntity {
    var toCamera: Camera {
        Camera(id: id, name: name, roverID: roverID, fullName: fullName)
    }
}

extension Rover {
    var toEntity: RoverEntity {
        RoverEntity(id: id, name: name, landingDate: landingDate, launchDate: launchDate, status: status, maxSol: maxSol,
                    maxDate: maxDate, totalPhotos: totalPhotos, cameras: cameras?.map(\.toEntity))
    }
}

extension RoverEntity {
    var toRover: Rover {
        Rover(id: id, name: name, landingDate: landingDate, launchDate: launchDate, status: status, maxSol: maxSol,
              maxDate: maxDate, totalPhotos: totalPhotos, cameras: cameras?.map(\.toLightCamera))
    }
}

extension LightCamera {
    var toEntity: LightCameraEntity {
        LightCameraEntity(name: name, fullName: fullName)
    }
}

extension LightCameraEntity {
    var toLightCamera: LightCamera {
        LightCamera(name: name, fullName: fullName)
    }
}
