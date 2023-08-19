//
//  
//  DetailViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 25/05/2023.
//
//

import Combine
import Foundation
import NasaModels
import Factory

@MainActor
final class DetailViewModel: ObservableObject, Sendable {
    @Published private(set) var photo: Photo

    private let checkIfPhotoIsPersisted = resolve(\UseCasesContainer.checkIfPhotoIsPersisted)
    private let getPersistedPhotos = resolve(\UseCasesContainer.getPersistedPhotos)
    private let savePhoto = resolve(\UseCasesContainer.savePhoto)
    private let removePersistedPhoto = resolve(\UseCasesContainer.removePersistedPhoto)
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
            self.photoIsPersisted ? await self.removePersistedPhoto(for: photo) : await self.savePhoto(with: photo)
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
