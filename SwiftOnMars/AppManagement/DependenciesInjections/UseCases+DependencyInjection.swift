//
//  UseCases+DependencyInjection.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Factory
import SOMDomainLayer

final class UseCasesContainer: SharedContainer {
    static let shared = UseCasesContainer()
    let manager = ContainerManager()
}

// MARK: - Mars mission photo usecases

extension UseCasesContainer {
    var getMarsPhotosBasedOnSol: Factory<any GetMarsPhotosBasedOnSolUseCase> {
        self { GetMarsPhotosBasedOnSol(repository: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var getMarsPhotosBasedOnDate: Factory<any GetMarsPhotosBasedOnDateUseCase> {
        self { GetMarsPhotosBasedOnDate(repository: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var getPhotosForSearchParams: Factory<any GetPhotosForSearchParamsUseCase> {
        self { GetPhotosForSearchParams(marsPhotoSolUsecase: self.getMarsPhotosBasedOnSol(),
                                        marsPhotoDateUsecase: self.getMarsPhotosBasedOnDate()) }
    }
}


// MARK: - Rover Informations usecase

extension UseCasesContainer {
    var getRoverInformations: Factory<any GetRoverInformationsUseCase> {
        self { GetRoverInformations(repository: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var getAllOrderedRovers: Factory<any GetAllOrderedRoversUseCase> {
        self { GetAllOrderedRovers(getRoverInformations: self.getRoverInformations()) }
    }

    var getRoverManifest: Factory<any GetRoverManifestUseCase> {
        self { GetRoverManifest(repository: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var getAllOrderedRoverManifests: Factory<any GetAllOrderedRoverManifestsUseCase> {
        self { GetAllOrderedRoverManifests(getRoverManifest: self.getRoverManifest()) }
    }
}

// MARK: - Search usecases

extension UseCasesContainer {
    var saveNewSearchParams: Factory<any SaveNewSearchParamsUseCase> {
        self { SaveNewSearchParams(searchRepository: RepositoriesContainer.shared.searchRepository()) }
    }

    var getCurrentSearchParameters: Factory<any GetCurrentSearchParametersUseCase> {
        self { GetCurrentSearchParameters(searchRepository: RepositoriesContainer.shared.searchRepository()) }
    }
}

// MARK: - Persistance

extension UseCasesContainer {
    var getPersistedPhotos: Factory<any GetPersistedPhotosUseCase> {
        self { GetPersistedPhotos(persistanceStorage: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var savePhoto: Factory<any SavePhotoUseCase> {
        self { SavePhoto(persistanceStorage: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var removePersistedPhoto: Factory<any RemovePersistedPhotoUseCase> {
        self { RemovePersistedPhoto(persistanceStorage: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var checkIfPhotoIsPersisted: Factory<any CheckIfPhotoIsPersistedUseCase> {
        self { CheckIfPhotoIsPersisted(getPersistedPhotosUseCase: self.getPersistedPhotos()) }
    }

    var persistAllPhotos: Factory<any PersistAllPhotosUseCase> {
        self { PersistAllPhotos(persistanceStorage: RepositoriesContainer.shared.marsMissionDataRepository()) }
    }

    var filterPersistedPhotos: Factory<any FilterPersistedPhotosUseCase> {
        self { FilterPersistedPhotos(getPersistedPhotosUseCase: self.getPersistedPhotos()) }
    }
}

extension UseCasesContainer: AutoRegistering {
    func autoRegister() {
        manager.defaultScope = .shared
    }
}
