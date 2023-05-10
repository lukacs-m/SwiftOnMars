//
//  
//  MainTabViewView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 12/04/2023.
//
//

import Factory
import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = MainTabViewModel()
    @Injected(\RouterContainer.tabViewRouter) private var tabRouter
    @InjectedObject(\RouterContainer.mainRouter) private var mainRouter
    @State private var selectedTabId = 0
    
    var body: some View {
        tabView
    }
}

struct MainTabViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


private  extension MainTabView {
    var tabView: some View {
        TabView(selection: $selectedTabId) {
            createTabItem(for: .missions)
            createTabItem(for: .favorites)
        }
        .onChange(of: selectedTabId) { id in
            mainRouter.popToRoot()
        }
    }
}

private extension MainTabView {
    func createTabItem(for destination: MainTabDestination) -> some View {
        tabRouter.navigate(to: destination)
            .withAppRouter()
            .withSheetDestinations(sheetDestinations: $mainRouter.presentedSheet)
            .navigationStackEmbeded(with: $mainRouter.path)
            .tabItem {
                Label(destination.name, systemImage: destination.icon)
            }
            .tag(destination.id)
            .accessibilityLabel(destination.name)

    }
}
