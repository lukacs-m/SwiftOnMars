//
//  GetAllOrderedRoverManifests.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

import NasaModels
import Foundation

//sourcery: AutoMockable
public protocol GetAllOrderedRoverManifestsUseCase: Sendable {
   func execute() async throws -> [RoverManifest]
}

public extension GetAllOrderedRoverManifestsUseCase {
    func callAsFunction() async throws -> [RoverManifest] {
      try await execute()
    }
}

public final class GetAllOrderedRoverManifests: GetAllOrderedRoverManifestsUseCase {
    private let getRoverManifest: any GetRoverManifestUseCase

    public init(getRoverManifest: any GetRoverManifestUseCase) {
        self.getRoverManifest = getRoverManifest
    }

    public func execute() async throws -> [RoverManifest] {
        async let curiosityInfos = getRoverManifest(for: .curiosity)
        async let opportunityInfos = getRoverManifest(for: .opportunity)
        async let spiritInfos = getRoverManifest(for: .spirit)
        async let perseveranceInfos = getRoverManifest(for: .perseverance)


        return try await [curiosityInfos, opportunityInfos, spiritInfos, perseveranceInfos].sorted(using: KeyPathComparator(\.photoManifest.name))
    }
}

