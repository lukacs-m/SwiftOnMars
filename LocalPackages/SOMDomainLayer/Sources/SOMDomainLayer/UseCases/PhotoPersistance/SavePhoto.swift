//
//  
//  SavePhoto.swift
//  
//
//  Created by Martin Lukacs on 07/05/2023.
//
//

import DomainInterfaces
import NasaModels

//sourcery: AutoMockable
public protocol SavePhotoUseCase: Sendable {
    func execute(with photo: Photo) async
}

public extension SavePhotoUseCase {
    func callAsFunction(with photo: Photo) async {
        await execute(with: photo)
    }
}

public final class SavePhoto: SavePhotoUseCase {
    private let persistanceStorage: any MarsPhotoStoring

    public init(persistanceStorage: any MarsPhotoStoring) {
        self.persistanceStorage = persistanceStorage
    }
    
    public func execute(with photo: Photo) async {
        await persistanceStorage.save(photo)
    }
}
