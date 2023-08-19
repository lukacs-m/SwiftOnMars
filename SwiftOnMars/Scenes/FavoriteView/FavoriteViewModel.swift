//
//  
//  FavoriteViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 10/05/2023.
//
//

import Foundation
import Factory
import Combine
import NasaModels

@MainActor
final class FavoriteViewModel: ObservableObject, Sendable {
    @Published private(set) var photos = [String: [Photo]]()
    @Published private(set) var currentFilter: PhotoFilterSelection = .defaultFilter

    private let filterPersistedPhotos = resolve(\UseCasesContainer.filterPersistedPhotos)
    private let removePersistedPhoto = resolve(\UseCasesContainer.removePersistedPhoto)
    private let persistAllPhotos = resolve(\UseCasesContainer.persistAllPhotos)

    @Published private(set) var selectedPhoto: Photo?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setUp()
    }

    func filter(by filterSelection: PhotoFilterSelection) {
        currentFilter = filterSelection
    }

    func persist() {
        Task { [weak self] in
            do {
                try await self?.persistAllPhotos()
            } catch {
                print("Woot \(error.localizedDescription)")
            }
        }
    }

    func toggleSelection(for photo: Photo? = nil) {
        selectedPhoto = photo
    }
}

private extension FavoriteViewModel {
    func setUp() {
        $currentFilter
            .flatMap { [weak self] fitler in
                return self?.filterPersistedPhotos(for: fitler) ?? Just([:]).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photos in
                self?.photos = photos
            }
            .store(in: &cancellables)
    }
}
