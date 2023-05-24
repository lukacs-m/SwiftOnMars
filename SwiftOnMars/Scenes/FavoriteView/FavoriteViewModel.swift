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
    @Published private(set) var photos = [Photo]()
    @Published private(set) var currentFilter: PhotoFilterSelection = .defaultFilter

    @Injected(\UseCasesContainer.filterPersistedPhotos) private var filterPersistedPhotos
    @Injected(\UseCasesContainer.removePersistedPhoto) private var removePersistedPhoto
    @Injected(\UseCasesContainer.persistAllPhotos) private var persistAllPhotos

    private var cancellables = Set<AnyCancellable>()

    init() {
        setUp()
    }

    func remove(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        let photo = photos[index]
        Task { [weak self] in
            await self?.removePersistedPhoto(for: photo)
        }
    }

    func filter(by filterSelection: PhotoFilterSelection) {
        currentFilter = filterSelection
    }

    func persist() {
        Task {
            do {
                try await persistAllPhotos()
            } catch {
                print("Woot \(error.localizedDescription)")
            }
        }
    }
}

private extension FavoriteViewModel {
    func setUp() {
        $currentFilter
            .flatMap { [weak self] fitler in
               return self?.filterPersistedPhotos(for: fitler) ?? Just([]).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photos in
                self?.photos = photos
            }
            .store(in: &cancellables)
    }
}
