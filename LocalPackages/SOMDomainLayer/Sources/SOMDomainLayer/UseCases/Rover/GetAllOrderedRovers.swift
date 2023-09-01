//
//
//  GetAllOrderedRovers.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//
//

import Foundation
import NasaModels

// sourcery: AutoMockable
public protocol GetAllOrderedRoversUseCase: Sendable {
    func execute() async throws -> [Rover]
}

public extension GetAllOrderedRoversUseCase {
    func callAsFunction() async throws -> [Rover] {
        try await execute()
    }
}

public final class GetAllOrderedRovers: GetAllOrderedRoversUseCase {
    private let getRoverInformations: any GetRoverInformationsUseCase

    public init(getRoverInformations: any GetRoverInformationsUseCase) {
        self.getRoverInformations = getRoverInformations
    }

    public func execute() async throws -> [Rover] {
        async let curiosityInfos = getRoverInformations(for: .curiosity)
        async let opportunityInfos = getRoverInformations(for: .opportunity)
        async let spiritInfos = getRoverInformations(for: .spirit)
        async let perseveranceInfos = getRoverInformations(for: .perseverance)

        return try await [curiosityInfos, opportunityInfos, spiritInfos, perseveranceInfos]
            .sorted(using: KeyPathComparator(\.name))
    }
}
