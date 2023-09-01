//
//
//  MainTabViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 12/04/2023.
//
//

import Factory
import Foundation

@MainActor
final class MainTabViewModel: ObservableObject, Sendable {
    private let persistAllPhotos = resolve(\UseCasesContainer.persistAllPhotos)

    init() {}

    func persist() {
        Task {
            try? await persistAllPhotos()
        }
    }
}
