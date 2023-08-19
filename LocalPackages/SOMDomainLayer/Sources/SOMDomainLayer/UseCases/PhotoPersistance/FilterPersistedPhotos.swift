//
//  FilterPersistedPhotos.swift
//
//
//  Created by Martin Lukacs on 22/05/2023.
//

import Combine
import NasaModels

// sourcery: AutoMockable
public protocol FilterPersistedPhotosUseCase: Sendable {
    func execute(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[String: [Photo]], Never>
}

public extension FilterPersistedPhotosUseCase {
    func callAsFunction(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[String: [Photo]], Never> {
        execute(for: filterSelection)
    }
}

public final class FilterPersistedPhotos: FilterPersistedPhotosUseCase {
    private let getPersistedPhotosUseCase: any GetPersistedPhotosUseCase

    public init(getPersistedPhotosUseCase: any GetPersistedPhotosUseCase) {
        self.getPersistedPhotosUseCase = getPersistedPhotosUseCase
    }

    public func execute(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[String: [Photo]], Never> {
        getPersistedPhotosUseCase().map { photos in
            switch filterSelection {
            case .defaultFilter:
                return ["Most Recent": photos]
            case .camera:
                return Dictionary(grouping: photos, by: { $0.camera.name }) // .sorted( by: { $0.0 < $1.0 })

//                photos.sorted  { $0.camera.name < $1.camera.name  }
            case .rover:
                return Dictionary(grouping: photos, by: { $0.rover.name }) // .sorted( by: { $0.0 < $1.0 })
//                return photos.sorted  { $0.rover.name < $1.rover.name  }
            case .sol:
                return Dictionary(grouping: photos, by: { String("\($0.sol)") }) // .sorted( by: { $0.0 < $1.0 })

//                return  photos.sorted  { $0.sol < $1.sol }
            }
        }.eraseToAnyPublisher()
    }
}
