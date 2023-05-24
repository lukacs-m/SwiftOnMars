//
//  FilterPersistedPhotos.swift
//  
//
//  Created by Martin Lukacs on 22/05/2023.
//

import Combine
import NasaModels

public protocol FilterPersistedPhotosUseCase: Sendable {
   func execute(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[Photo], Never>
}

public extension FilterPersistedPhotosUseCase {
    func callAsFunction(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[Photo], Never> {
        execute(for: filterSelection)
    }
}

public final class FilterPersistedPhotos: FilterPersistedPhotosUseCase {
    private let getPersistedPhotosUseCase: any GetPersistedPhotosUseCase

    public init(getPersistedPhotosUseCase: any GetPersistedPhotosUseCase) {
        self.getPersistedPhotosUseCase = getPersistedPhotosUseCase
    }

    public func execute(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[Photo], Never> {
        switch filterSelection {
        case .defaultFilter:
          return getPersistedPhotosUseCase().eraseToAnyPublisher()
        case .camera:
            return getPersistedPhotosUseCase().map { photos in
                photos.sorted  { $0.camera.name < $1.camera.name  }
            }.eraseToAnyPublisher()
        case .rover:
            return getPersistedPhotosUseCase().map { photos in
                photos.sorted  { $0.rover.name < $1.rover.name  }
            }.eraseToAnyPublisher()
        case .sol:
            return getPersistedPhotosUseCase().map { photos in
                photos.sorted  { $0.sol < $1.sol }
            }.eraseToAnyPublisher()
        }
    }
}
