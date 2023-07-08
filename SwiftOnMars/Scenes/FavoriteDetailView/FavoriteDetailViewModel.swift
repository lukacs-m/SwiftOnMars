//
//  
//  FavoriteDetailViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 27/05/2023.
//
//

import Foundation
import NasaModels

@MainActor
final class FavoriteDetailViewModel: ObservableObject, Sendable {
    @Published private(set) var photo: Photo

    var bool: Bool? = true
    
    init(photo: Photo) {
        self.photo = photo
        setUp()
    }
}

private extension FavoriteDetailViewModel {
    func setUp() {

    }
}
