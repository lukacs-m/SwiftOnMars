//
//  
//  DetailViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 25/05/2023.
//
//

import Foundation
import NasaModels

@MainActor
final class DetailViewModel: ObservableObject, Sendable {
    @Published private(set) var photo: Photo

    init(photo: Photo) {
        self.photo = photo
        setUp()
    }
}

private extension DetailViewModel {
    func setUp() {
    }
}
