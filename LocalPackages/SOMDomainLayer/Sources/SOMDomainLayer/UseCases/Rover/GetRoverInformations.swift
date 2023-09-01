//
//
//  GetRoverInformations.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//
//

import DomainInterfaces
import NasaModels

// sourcery: AutoMockable
public protocol GetRoverInformationsUseCase: Sendable {
    func execute(for roverId: RoverIdentification) async throws -> Rover
}

public extension GetRoverInformationsUseCase {
    func callAsFunction(for roverId: RoverIdentification) async throws -> Rover {
        try await execute(for: roverId)
    }
}

public final class GetRoverInformations: GetRoverInformationsUseCase {
    private let repository: MarsMissionInformationsServicing

    public init(repository: MarsMissionInformationsServicing) {
        self.repository = repository
    }

    public func execute(for roverId: RoverIdentification) async throws -> Rover {
        try await repository.getInformation(for: roverId)
    }
}
