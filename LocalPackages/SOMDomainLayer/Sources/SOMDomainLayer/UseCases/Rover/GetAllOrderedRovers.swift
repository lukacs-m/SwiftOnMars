//
//  
//  GetAllOrderedRovers.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//
//

import NasaModels
import Foundation

public protocol GetAllOrderedRoversUseCase: Sendable {
   func execute() async throws -> [Rover]
}

public extension GetAllOrderedRoversUseCase {
    func callAsFunction() async throws -> [Rover] {
      try await execute()
    }
}

public final class GetAllOrderedRovers: GetAllOrderedRoversUseCase {
    private let getRoverUseCase: GetRoverInformationsUseCase

    public init(getRoverUseCase: GetRoverInformationsUseCase) {
        self.getRoverUseCase = getRoverUseCase
    }
    
    public func execute() async throws -> [Rover] {
        let curiosityInfos = try await getRoverUseCase(for: .curiosity)
        let opportunityInfos = try await getRoverUseCase(for: .opportunity)
        let spiritInfos = try await getRoverUseCase(for: .spirit)
        return [curiosityInfos, opportunityInfos, spiritInfos].sorted(using: KeyPathComparator(\.name))
    }
}
