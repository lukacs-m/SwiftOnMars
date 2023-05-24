//
//  
//  MainTabViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 12/04/2023.
//
//

import Foundation
import Factory

@MainActor
final class MainTabViewModel: ObservableObject, Sendable {
    @Injected(\UseCasesContainer.persistAllPhotos) private var persistAllPhotos

    init() {
        setUp()
    }

    func persist() {
        Task {
            try? await persistAllPhotos()
        }
    }
}

private extension MainTabViewModel {
    func setUp() {}
}

