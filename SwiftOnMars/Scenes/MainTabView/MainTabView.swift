//
//
//  MainTabViewView.swift
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
    @State private var selectedTabId = 0

    var body: some View {
        tabView
            .onChange(of: scenePhase) { newPhase in
                guard newPhase == .background else {
                    return
                }
                viewModel.persist()
            }
    }
}

struct MainTabViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

private extension MainTabView {
    var tabView: some View {
        TabView(selection: $selectedTabId) {
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
            .tag(destination.id)
            .accessibilityLabel(destination.name)
    }
}
