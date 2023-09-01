//
//
//  GetCurrentSearchParameters.swift
//
//
//  Created by Martin Lukacs on 29/04/2023.
//
//

import Combine
import DomainInterfaces
import NasaModels

// sourcery: AutoMockable
public protocol GetCurrentSearchParametersUseCase: Sendable {
    func execute() -> SearchParameters
    func executePublisher() -> CurrentValueSubject<SearchParameters, Never>
}

public extension GetCurrentSearchParametersUseCase {
    func callAsFunction() -> SearchParameters {
        execute()
    }

    func callAsFunction() -> CurrentValueSubject<SearchParameters, Never> {
        executePublisher()
    }
}

public final class GetCurrentSearchParameters: GetCurrentSearchParametersUseCase {
    private let searchRepository: any SearchService

    public init(searchRepository: any SearchService) {
        self.searchRepository = searchRepository
    }

    public func execute() -> SearchParameters {
        searchRepository.currentSearchParameters.value
    }

    public func executePublisher() -> CurrentValueSubject<SearchParameters, Never> {
        searchRepository.currentSearchParameters
    }
}
