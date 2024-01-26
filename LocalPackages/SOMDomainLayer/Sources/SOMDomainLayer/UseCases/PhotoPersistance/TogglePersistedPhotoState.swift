//
//
//  TogglePersistedPhotoState.swift
//
//
//  Created by Martin Lukacs on 14/01/2024.
//
//

import DomainInterfaces
import NasaModels

public protocol TogglePersistedPhotoStateUseCase: Sendable {
    func execute(for photo: Photo) async
}

public extension TogglePersistedPhotoStateUseCase {
    func callAsFunction(for photo: Photo) async {
        await execute(for: photo)
    }
}

public final class TogglePersistedPhotoState: TogglePersistedPhotoStateUseCase {
    private let persistanceStorage: any MarsPhotoStoring
    private let isPhotoPersisted: any CheckIfPhotoIsPersistedUseCase

    public init(persistanceStorage: any MarsPhotoStoring,
                isPhotoPersisted: any CheckIfPhotoIsPersistedUseCase) {
        self.persistanceStorage = persistanceStorage
        self.isPhotoPersisted = isPhotoPersisted
    }

    public func execute(for photo: Photo) async {
        isPhotoPersisted(for: photo) ? await persistanceStorage.remove(photo) : await persistanceStorage.save(photo)
    }
}
