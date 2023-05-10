//
//  Routers+DependenciesInjections.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Foundation
@preconcurrency import Factory

@MainActor
final class RouterContainer: SharedContainer {
    static let shared = RouterContainer()
    let manager = ContainerManager()
}

extension RouterContainer {
    var tabViewRouter: Factory<TabViewRouter> {
        self { TabViewRouter() }
    }

    var mainRouter: Factory<MainPathRouter> {
        self { MainPathRouter() }
    }
}

extension RouterContainer: AutoRegistering {
    nonisolated func autoRegister() {
        manager.defaultScope = .singleton
    }
}
