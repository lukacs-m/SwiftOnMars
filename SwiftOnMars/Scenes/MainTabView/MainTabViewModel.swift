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
    private let persistAllPhotos = resolve(\UseCasesContainer.persistAllPhotos)

    init() {}

    func persist() {
        Task {
            try? await persistAllPhotos()
        }
    }
}
