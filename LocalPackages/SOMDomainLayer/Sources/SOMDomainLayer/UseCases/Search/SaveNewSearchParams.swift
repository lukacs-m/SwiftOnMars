//
//  
//  SaveNewSearchParams.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//
//

import NasaModels
import DomainInterfaces

public protocol SaveNewSearchParamsUseCase: Sendable {
    func execute(with params: SearchParameters)
}

public extension SaveNewSearchParamsUseCase {
    func callAsFunction(with params: SearchParameters) {
        execute(with: params)
    }
}

public final class SaveNewSearchParams: SaveNewSearchParamsUseCase {
    private let searchRepository: any SearchService

    public init(searchRepository: any SearchService) {
        self.searchRepository = searchRepository
    }

    public func execute(with params: SearchParameters) {
        searchRepository.setSearchParameters(with: params)
    }
}
