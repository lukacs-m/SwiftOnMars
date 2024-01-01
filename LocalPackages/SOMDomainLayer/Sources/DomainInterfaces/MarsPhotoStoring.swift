//
//  MarsPhotoStoring.swift
//
//
//  Created by Martin Lukacs on 07/05/2023.
//

import Combine
import Foundation
import NasaModels

// sourcery: AutoMockable
public protocol MarsPhotoStoring: Sendable {
    var getPersistedPhotos: CurrentValueSubject<[Photo], Never> { get }

    func save(_ photo: Photo) async
    func remove(_ photo: Photo) async
    func clear() async throws
}
