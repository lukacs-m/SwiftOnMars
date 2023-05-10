//
//  Repositories+DependencyInjection.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Factory
import DomainInterfaces
import SOMDataLayer

typealias MarsMissionContentServicing = MarsMissionInformationsServicing & MarsPhotoStoring

final class RepositoriesContainer: SharedContainer {
    static let shared = RepositoriesContainer()
    let manager = ContainerManager()
}

extension RepositoriesContainer {
    var marsMissionDataRepository: Factory<MarsMissionContentServicing> {
        self { MarsMissionDataRepository() }
    }

    var searchRepository: Factory<SearchService> {
        self { SearchRepository() }
    }
}

extension RepositoriesContainer: AutoRegistering {
    func autoRegister() {
        manager.defaultScope = .singleton
    }
}
