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
        Text("Add some view here")
    }
}

struct MainTabViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


extension MainTabView {
    private var tabView: some View {
        TabView(selection: $selectedTabId) {
            createTabItem(for: .home)
            // No recommended poscast are available for now on PIPE
//            createTabItem(for: .podcasts)
            createTabItem(for: .favorites)
//            createTabItem(for: .search)
//            if let track = viewModel.currentTrack {
//                fullScreenDisplay(track: track)
//                    .tabItem {
//                        Text(MainTabDestination.nowPlaying.getName())
//                    }
//                    .tag(MainTabDestination.nowPlaying.getTabNumber())
//                    .sheet(isPresented: $showPlayer) {
//                        LazyView(router.goToPage(for: .nowPlaying))
//                    }
//            }
//            createTabItem(for: .settings)
        }
        .onChange(of: selectedTabId) { _ in
//            viewModel.clearSearchQuery()
        }
    }
}

private extension MainTabView {
    func createTabItem(for destination: MainTabDestination) -> some View {
        router.goToScene(for: destination)
            .tabItem {
                Text(destination.name)
            }
            .tag(destination.id)
            .accessibilityLabel(destination.name)
    }
}
//
//private var tabBarView: some View {
//  TabView(selection: .init(get: {
//    selectedTab
//  }, set: { newTab in
//    if newTab == selectedTab {
//      /// Stupid hack to trigger onChange binding in tab views.
//      popToRootTab = .other
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//        popToRootTab = selectedTab
//      }
//    }
//
//    HapticManager.shared.fireHaptic(of: .tabSelection)
//    SoundEffectManager.shared.playSound(of: .tabSelection)
//
//    selectedTab = newTab
//
//    DispatchQueue.main.async {
//      if selectedTab == .notifications,
//         let token = appAccountsManager.currentAccount.oauthToken
//      {
//        userPreferences.setNotification(count: 0, token: token)
//        watcher.unreadNotificationsCount = 0
//      }
//    }
//
//  })) {
//    ForEach(availableTabs) { tab in
//      tab.makeContentView(popToRootTab: $popToRootTab)
//        .tabItem {
//          if userPreferences.showiPhoneTabLabel {
//            tab.label
//              .labelStyle(TitleAndIconLabelStyle())
//          } else {
//            tab.label
//              .labelStyle(IconOnlyLabelStyle())
//          }
//        }
//        .tag(tab)
//        .badge(badgeFor(tab: tab))
//        .toolbarBackground(theme.primaryBackgroundColor.opacity(0.50), for: .tabBar)
//    }
//  }
//  .id(appAccountsManager.currentClient.id)
//}
