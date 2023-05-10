//
//  SearchService.swift
//  
//
//  Created by Martin Lukacs on 29/04/2023.
//

import Combine
import Foundation
import NasaModels

public protocol SearchService: Sendable {
    var currentSearchParameters: CurrentValueSubject<SearchParameters, Never> { get }

    func setSearchParameters(with params: SearchParameters)
}
