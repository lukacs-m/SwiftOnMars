//
//  SearchRepository.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

@preconcurrency import Combine
import Foundation
import DomainInterfaces
import NasaModels

public final class SearchRepository: SearchService {
    public let currentSearchParameters: CurrentValueSubject<SearchParameters, Never> = .init(SearchParameters.default)

    public init() {}
    
    public func setSearchParameters(with params: SearchParameters) {
        currentSearchParameters.send(params)
    }
}
