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
        getPersistedPhotosUseCase().map { photos in
            switch filterSelection {
            case .defaultFilter:
                return photos
            case .camera:
                return photos.sorted  { $0.camera.name < $1.camera.name  }
            case .rover:
                return photos.sorted  { $0.rover.name < $1.rover.name  }
            case .sol:
                return  photos.sorted  { $0.sol < $1.sol }
            }
        }.eraseToAnyPublisher()
    }
}
