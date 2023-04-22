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
    @Injected(\RouterContainer.tabViewRouter) private var router
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
            print("Selected id: \(id)")
        }
    }
}

private extension MainTabView {
    func createTabItem(for destination: MainTabDestination) -> some View {
        router.goToScene(for: destination)
            .tabItem {
                Label(destination.name, systemImage: destination.icon)
            }
            .tag(destination.id)
            .accessibilityLabel(destination.name)
    }
}
