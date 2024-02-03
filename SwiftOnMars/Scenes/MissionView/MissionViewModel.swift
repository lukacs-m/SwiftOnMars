//
//
//  MissionViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//
//

import Combine
import Factory
import Foundation
import NasaModels

@MainActor
final class MissionViewModel: ObservableObject, Sendable {
    @Published private(set) var photos = [Photo]()
    @Published private(set) var isLoadingPage = false

    private let getPhotosForSearchParams = resolve(\UseCasesContainer.getPhotosForSearchParams)
    private let getCurrentSearchParameters = resolve(\UseCasesContainer.getCurrentSearchParameters)
    private let checkIfPhotoIsPersisted = resolve(\UseCasesContainer.checkIfPhotoIsPersisted)
    private let getPersistedPhotos = resolve(\UseCasesContainer.getPersistedPhotos)
    private let togglePersistedPhotoState = resolve(\UseCasesContainer.togglePersistedPhotoState)

    private var currentPage = 1
    private var canLoadMorePages = true
    private var searchParameters: SearchParameters!
    private var cancellables = Set<AnyCancellable>()

    var currentRover: String {
        searchParameters.roverId.rawValue
    }

    var searchInfos: String {
        searchParameters.searchBySol ? "\(searchParameters.sol)" : searchParameters.earthDate?
            .toEarthDateDescription ?? ""
    }

    var isSolSearch: Bool {
        searchParameters.searchBySol
    }

    var currentCamera: String? {
        searchParameters.camera
    }

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

        Task { [weak self] in
            guard let self else {
                return
            }
            isLoadingPage = true

            defer {
                isLoadingPage = false
            }

            do {
                if Task.isCancelled {
                    return
                }
                let newPhotos = try await getPhotosForSearchParams(for: searchParameters,
                                                                   and: currentPage)
                guard !newPhotos.isEmpty else {
                    canLoadMorePages = false
                    return
                }

                photos.append(contentsOf: newPhotos)
                currentPage += 1
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
            await togglePersistedPhotoState(for: photo)
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
