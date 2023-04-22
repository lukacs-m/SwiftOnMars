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
}

extension RouterContainer {
    func autoRegister() {
        manager.defaultScope = .singleton
    }
}
