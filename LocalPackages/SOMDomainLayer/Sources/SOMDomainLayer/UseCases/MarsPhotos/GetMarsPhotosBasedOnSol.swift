//
//  
//  GetMarsPhotosBasedOnSol.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//
//

import DomainInterfaces
import NasaModels

public protocol GetMarsPhotosBasedOnSolUseCase: Sendable {
    func execute(for roverId: RoverIdentification,
                 on sol: Int,
                 for camera: String?,
                 and page: Int?) async throws -> [Photo]
}

public extension GetMarsPhotosBasedOnSolUseCase {
    func execute(for roverId: RoverIdentification,
                 on sol: Int,
                 for camera: String? = nil,
                 and page: Int? = nil) async throws -> [Photo] {
       try await execute(for: roverId, on: sol, for: camera, and: page)
    }
}

public extension GetMarsPhotosBasedOnSolUseCase {
    func callAsFunction(for roverId: RoverIdentification,
                        on sol: Int,
                        for camera: String? = nil,
                        and page: Int? = nil) async throws -> [Photo] {
      try await execute(for: roverId, on: sol, for: camera, and: page)
    }
}

public final class GetMarsPhotosBasedOnSol: GetMarsPhotosBasedOnSolUseCase {
    private let repository: MarsMissionInformationsServicing

    public init(repository: MarsMissionInformationsServicing) {
        self.repository = repository
    }

    public func execute(for roverId: RoverIdentification,
                 on sol: Int,
                 for camera: String?,
                 and page: Int?) async throws -> [Photo] {
        try await repository.getPhotosByMartinSol(for: roverId, on: sol, for: camera, and: page)
    }
}
