//
//
//  GetMarsPhotosBasedOnDate.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//
//

import DomainInterfaces
import NasaModels

// sourcery: AutoMockable
public protocol GetMarsPhotosBasedOnDateUseCase: Sendable {
    func execute(for roverId: RoverIdentification,
                 at date: String,
                 for camera: String?,
                 and page: Int?) async throws -> [Photo]
}

public extension GetMarsPhotosBasedOnDateUseCase {
    func execute(for roverId: RoverIdentification,
                 at date: String,
                 for camera: String? = nil,
                 and page: Int? = nil) async throws -> [Photo] {
        try await execute(for: roverId, at: date, for: camera, and: page)
    }
}

public extension GetMarsPhotosBasedOnDateUseCase {
    func callAsFunction(for roverId: RoverIdentification,
                        at date: String,
                        for camera: String? = nil,
                        and page: Int? = nil) async throws -> [Photo] {
        try await execute(for: roverId, at: date, for: camera, and: page)
    }
}

public final class GetMarsPhotosBasedOnDate: GetMarsPhotosBasedOnDateUseCase {
    private let repository: any MarsMissionInformationsServicing

    public init(repository: any MarsMissionInformationsServicing) {
        self.repository = repository
    }

    public func execute(for roverId: RoverIdentification,
                        at date: String,
                        for camera: String?,
                        and page: Int?) async throws -> [Photo] {
        try await repository.getPhotosByDate(for: roverId,
                                             at: date,
                                             for: camera,
                                             and: page)
    }
}
