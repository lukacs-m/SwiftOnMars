//
//
//  CheckIfPhotoIsPersisted.swift
//
//
//  Created by Martin Lukacs on 07/05/2023.
//

import Combine
import DomainInterfaces
import Foundation
import NasaModels

// sourcery: AutoMockable
public protocol CheckIfPhotoIsPersistedUseCase: Sendable {
    func execute(for photo: Photo) -> Bool
}

public extension CheckIfPhotoIsPersistedUseCase {
    func callAsFunction(for photo: Photo) -> Bool {
        execute(for: photo)
    }
}

public final class CheckIfPhotoIsPersisted: CheckIfPhotoIsPersistedUseCase, @unchecked Sendable {
    private var persistedPhotos = [Photo]()
    private var cancellable: AnyCancellable?
    private let getPersistedPhotosUseCase: any GetPersistedPhotosUseCase

    public init(getPersistedPhotosUseCase: any GetPersistedPhotosUseCase) {
        self.getPersistedPhotosUseCase = getPersistedPhotosUseCase
        cancellable = getPersistedPhotosUseCase()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photos in
                self?.persistedPhotos = photos
            }
    }

    deinit {
        cancellable?.cancel()
        cancellable = nil
    }

    public func execute(for photo: Photo) -> Bool {
        persistedPhotos.contains { $0.id == photo.id }
    }
}
