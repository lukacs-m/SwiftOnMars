//
//  GetRoverManifest.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

import DomainInterfaces
import NasaModels

//sourcery: AutoMockable
public protocol GetRoverManifestUseCase: Sendable {
    func execute(for roverId: RoverIdentification) async throws -> RoverManifest
}

public extension GetRoverManifestUseCase {
    func callAsFunction(for roverId: RoverIdentification) async throws -> RoverManifest {
        try await execute(for: roverId)
    }
}

public final class GetRoverManifest: GetRoverManifestUseCase {
    private let repository: MarsMissionInformationsServicing

    public init(repository: MarsMissionInformationsServicing) {
        self.repository = repository
    }

    public func execute(for roverId: RoverIdentification) async throws -> RoverManifest {
        try await repository.getManifest(for: roverId)
    }
}
