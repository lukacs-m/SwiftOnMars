//
//  Services+DependencyInjection.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 31/12/2023.
//

import DomainInterfaces
import Factory
import SOMDataLayer
import SwiftData

extension ModelConfiguration: @unchecked Sendable {}

final class ServicesContainer: SharedContainer {
    static let shared = ServicesContainer()
    let manager = ContainerManager()
}

extension ServicesContainer {
    var persistenceService: Factory<any PersistenceServicing> {
        self {
            do {
                return try PersistenceService(with: ModelConfiguration(for: PhotoEntity.self))
            } catch {
                fatalError("Should have persistence storage")
            }
        }
    }
}

extension ServicesContainer: AutoRegistering {
    func autoRegister() {
        manager.defaultScope = .singleton
    }
}
