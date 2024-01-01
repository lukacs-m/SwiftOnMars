//
//
//  MainTabViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 12/04/2023.
//
//

import Factory
import Foundation

@MainActor
final class MainTabViewModel: ObservableObject, Sendable {
    private let routerController: any RoutingController

    init(routerController: any RoutingController = RouterContainer.shared) {
        self.routerController = routerController
    }

    func reset(router: MainTabDestination) {
        Task { [weak self] in
            await self?.routerController.reset(router: router)
        }
    }
}
