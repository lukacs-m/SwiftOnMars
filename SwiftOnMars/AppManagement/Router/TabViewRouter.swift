//
//  TabViewRouter.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Foundation
import SwiftUI

// MARK: - TabView Destinations

enum MainTabDestination {
    case missions
    case favorites

    var name: LocalizedStringKey {
        switch self {
        case .missions:
            "Missions"
        case .favorites:
            "Favorites"
        }
    }

    var id: Int {
        switch self {
        case .missions:
            0
        case .favorites:
            1
        }
    }

    var icon: String {
        switch self {
        case .missions:
            "moon.haze.circle"
        case .favorites:
            "heart.circle"
        }
    }
}

@MainActor
final class TabViewRouter {
    @ViewBuilder
    func navigate(to destination: MainTabDestination) -> some View {
        switch destination {
        case .missions:
            MissionView()
        case .favorites:
            FavoriteView()
        }
    }
}
