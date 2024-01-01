//
//
//  MainTabView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 12/04/2023.
//
//

import Factory
import SOMDesignSystem
import SwiftUI

struct MainTabView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = MainTabViewModel()
    private let tabRouter = resolve(\RouterContainer.tabViewRouter)

    @State private var selectedTab = MainTabDestination.missions

    var body: some View {
        tabView
    }
}

struct MainTabViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

private extension MainTabView {
    var tabView: some View {
        TabView(selection: tabSelection) {
            createTabItem(for: .missions)
            createTabItem(for: .favorites)
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .tint(Asset.Colors.Main.primaryDarkest.color)
    }
}

private extension MainTabView {
    @ViewBuilder
    func createTabItem(for destination: MainTabDestination) -> some View {
        tabRouter.navigate(to: destination)
            .tabItem {
                Label(destination.name, systemImage: destination.icon)
            }
            .tag(destination)
            .accessibilityLabel(destination.name)
    }
}

extension MainTabView {
    var tabSelection: Binding<MainTabDestination> {
        Binding {
            selectedTab
        }

        set: { tappedTab in
            if tappedTab == selectedTab {
                // User tapped on the currently active tab icon => Pop to root/Scroll to top
                viewModel.reset(router: selectedTab)
            }
            selectedTab = tappedTab
        }
    }
}
