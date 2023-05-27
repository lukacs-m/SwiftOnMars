//
//  MarsPhotoStoring.swift
//  
//
//  Created by Martin Lukacs on 07/05/2023.
//

import Combine
import NasaModels
import Foundation

//sourcery: AutoMockable
public protocol MarsPhotoStoring: Sendable {
    var getPersistedPhotos: CurrentValueSubject<[Photo], Never> { get }

    func save(_ photo: Photo) async
    func remove(_ photo: Photo) async
    func persist() async throws
    func clear() async throws
}
