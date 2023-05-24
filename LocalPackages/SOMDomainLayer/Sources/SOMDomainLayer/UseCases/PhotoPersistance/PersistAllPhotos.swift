//
//  
//  PersistAllPhotos.swift
//  
//
//  Created by Martin Lukacs on 11/05/2023.
//
//

import DomainInterfaces

public protocol PersistAllPhotosUseCase: Sendable {
   func execute() async throws
}

public extension PersistAllPhotosUseCase {
    func callAsFunction() async throws {
        try await execute()
    }
}

public final class PersistAllPhotos: PersistAllPhotosUseCase {
    private let persistanceStorage: any MarsPhotoStoring

    public init(persistanceStorage: any MarsPhotoStoring) {
        self.persistanceStorage = persistanceStorage
    }

    public func execute() async throws {
        try await persistanceStorage.persist()
    }
}
