//
//  
//  MissionViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//
//

import Combine
import Foundation
import NasaModels
import Factory

@MainActor
final class MissionViewModel: ObservableObject, Sendable {
    @Published private(set) var photos = [Photo]()
    @Published private(set) var isLoadingPage = false

    @Injected(\UseCasesContainer.getMarsPhotosBasedOnSol) private var getMarsPhotosBasedOnSol
    @Injected(\UseCasesContainer.getMarsPhotosBasedOnDate) private var getMarsPhotosBasedOnDate
    @Injected(\UseCasesContainer.getCurrentSearchParameters) private var getCurrentSearchParameters
    @Injected(\UseCasesContainer.checkIfPhotoIsPersisted) private var checkIfPhotoIsPersisted
    @Injected(\UseCasesContainer.getPersistedPhotos) private var getPersistedPhotos
    @Injected(\UseCasesContainer.savePhoto) private var savePhoto
    @Injected(\UseCasesContainer.removePersistedPhoto) private var removePersistedPhoto

    var currentRover: String {
        searchParameters.roverId.rawValue
    }

    var searchInfos: String {
        searchParameters.searchBySol ? "\(searchParameters.sol)" : searchParameters.earthDate?.toEarthDateDescription ?? ""
    }

    var isSolSearch: Bool {
        searchParameters.searchBySol
    }

    var currentCamera: String? {
        searchParameters.camera
    }

    private var currentPage = 1
    private var canLoadMorePages = true
    private var searchParameters: SearchParameters!
    private var cancellables = Set<AnyCancellable>()

    init() {
        searchParameters = getCurrentSearchParameters().value
        setUp()
    }

    func loadMoreContentIfNeeded(currentPhoto photo: Photo) {
        let thresholdIndex = photos.index(photos.endIndex, offsetBy: -5)
        if photos.firstIndex(where: { $0.id == photo.id }) == thresholdIndex {
            fetchPhotos()
        }
    }

    func fetchPhotos() {
        guard !isLoadingPage, canLoadMorePages else {
            return
        }

        isLoadingPage = true
        Task { [weak self] in
            guard let self else {
                return
            }
            do {
                let newPhotos = self.searchParameters.searchBySol ?  try await self.getMarsPhotosBasedOnSol(for: self.searchParameters.roverId,
                                                                                                            at: self.searchParameters.sol,
                                                                                                            for: self.searchParameters.camera,
                                                                                                            and: self.currentPage) :
                try await self.getMarsPhotosBasedOnDate(for: self.searchParameters.roverId,
                                                   at: self.searchParameters.earthDate?.toEarthDateDescription ?? Date().toEarthDateDescription,
                                                   for: self.searchParameters.camera,
                                                   and: self.currentPage)
                self.isLoadingPage = false
                guard newPhotos.count != 0 else {
                    self.canLoadMorePages = false
                    return
                }

                self.photos.append(contentsOf: newPhotos)
                self.currentPage += 1
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func isPersisted(for photo: Photo) -> Bool {
        checkIfPhotoIsPersisted(for: photo)
    }

    func togglePersistantState(for photo: Photo) {
        Task { [weak self] in
            guard let self else {
                return
            }
            self.isPersisted(for: photo) ? await self.removePersistedPhoto(for: photo) : await self.savePhoto(with: photo)
        }
    }
}

private extension MissionViewModel {
    func setUp() {
        getCurrentSearchParameters()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchParameters in
                self?.searchParameters = searchParameters
                self?.resetAll()
                self?.fetchPhotos()
            }
            .store(in: &cancellables)

        getPersistedPhotos()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func resetAll() {
        currentPage = 1
        photos.removeAll()
        canLoadMorePages = true
    }
}
