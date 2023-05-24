//
//  MainRouter.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Foundation
import SwiftUI

public enum RouterDestination: Hashable {
  case missionDetail(id: String)
}

public enum SheetDestination: Identifiable {
    case searchSettings

  public var id: String {
    switch self {
    case .searchSettings:
        return "searchSettings"
    }
  }
}

@MainActor
final class MainPathRouter: ObservableObject {
    @Published public var path = NavigationPath()
    @Published public var presentedSheet: SheetDestination?

    func navigate(to: RouterDestination) {
        path.append(to)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func back(to numberOfScreen: Int = 1) {
        path.removeLast(numberOfScreen)
    }
}
