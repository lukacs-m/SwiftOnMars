//
//  Repositories+DependencyInjection.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import DomainInterfaces
import Factory
import SOMDataLayer
import SwiftData

typealias MarsMissionContentServicing = MarsMissionInformationsServicing & MarsPhotoStoring

final class RepositoriesContainer: SharedContainer {
    static let shared = RepositoriesContainer()
    let manager = ContainerManager()
}

extension RepositoriesContainer {
    var marsMissionDataRepository: Factory<any MarsMissionContentServicing> {
        self { MarsMissionDataRepository(persistantStorage: ServicesContainer.shared.persistenceService()) }
    }

    var searchRepository: Factory<any SearchService> {
        self { SearchRepository() }
    }
}

extension RepositoriesContainer: AutoRegistering {
    func autoRegister() {
        manager.defaultScope = .singleton
    }
}
