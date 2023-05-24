//
//  
//  RemovePersistedPhoto.swift
//  
//
//  Created by Martin Lukacs on 07/05/2023.
//
//

import DomainInterfaces
import NasaModels

public protocol RemovePersistedPhotoUseCase: Sendable {
    func execute(for photo: Photo) async
}

public extension RemovePersistedPhotoUseCase {
    func callAsFunction(for photo: Photo) async  {
       await execute(for: photo)
    }
}

public final class RemovePersistedPhoto: RemovePersistedPhotoUseCase {
    private let persistanceStorage: any MarsPhotoStoring

    public init(persistanceStorage: any MarsPhotoStoring) {
        self.persistanceStorage = persistanceStorage
    }

    
    public func execute(for photo: Photo) async {
      await persistanceStorage.remove(photo)
    }
}
