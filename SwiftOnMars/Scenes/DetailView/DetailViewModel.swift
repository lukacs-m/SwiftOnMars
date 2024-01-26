//
//
//  DetailViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 25/05/2023.
//
//

import Combine
import Factory
import Foundation
import NasaModels

@MainActor
final class DetailViewModel: ObservableObject, Sendable {
    @Published private(set) var photo: Photo

    private let checkIfPhotoIsPersisted = resolve(\UseCasesContainer.checkIfPhotoIsPersisted)
    private let getPersistedPhotos = resolve(\UseCasesContainer.getPersistedPhotos)
    private let togglePersistedPhotoState = resolve(\UseCasesContainer.togglePersistedPhotoState)
    private var cancellables = Set<AnyCancellable>()

    init(photo: Photo) {
        self.photo = photo
        setUp()
    }

    var photoIsPersisted: Bool {
        checkIfPhotoIsPersisted(for: photo)
    }

    func togglePhotoPersistantState() {
        Task { [weak self] in
            guard let self else {
                return
            }
            await togglePersistedPhotoState(for: photo)
        }
    }
}

private extension DetailViewModel {
    func setUp() {
        getPersistedPhotos()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
