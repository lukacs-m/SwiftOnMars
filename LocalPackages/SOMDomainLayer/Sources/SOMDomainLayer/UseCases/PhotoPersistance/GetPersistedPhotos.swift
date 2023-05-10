//
//  
//  GetPersistedPhotos.swift
//  
//
//  Created by Martin Lukacs on 07/05/2023.
//
//

import Combine
import DomainInterfaces
import NasaModels

public protocol GetPersistedPhotosUseCase: Sendable {
   func execute() -> AnyPublisher<[Photo], Never>
}

public extension GetPersistedPhotosUseCase {
    func callAsFunction() -> AnyPublisher<[Photo], Never> {
        execute()
    }
}

public final class GetPersistedPhotos: GetPersistedPhotosUseCase {
    private let persistanceStorage: any MarsPhotoStoring

    public init(persistanceStorage: any MarsPhotoStoring) {
        self.persistanceStorage = persistanceStorage
    }
    
    public func execute() -> AnyPublisher<[Photo], Never> {
        persistanceStorage.getPersistedPhotos.eraseToAnyPublisher()
    }
}
