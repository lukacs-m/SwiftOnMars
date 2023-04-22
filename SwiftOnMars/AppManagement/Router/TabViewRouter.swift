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
    case home
    case favorites

    var name: LocalizedStringKey {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favorites"
        }
    }

    var id: Int {
        switch self {
        case .home:
            return 0
        case .favorites:
            return 1
        }
    }
}

@MainActor
final class TabViewRouter {
    @ViewBuilder
    func goToScene(for destination: MainTabDestination) -> some View {
        switch destination {
        case .home:
            Text("Home")
//            HomeView()
        case .favorites:
            Text("Favorites")
//            FavoriteView()
        }
    }
}

//
//
//
//
//
//
//
//
//final class MainCoordinator {}
//
//// Main TabView Destinations
//
//
//
//extension MainCoordinator {
//    @ViewBuilder
//    func goToPage(for destination: MainTabDestination) -> some View {
//        switch destination {
//        case .music:
//            HomeView()
//        case .podcasts:
//            Text(destination.getName())
//        case .favorites:
//            FavoriteView()
//        case .search:
//            SearchView()
//        case .nowPlaying:
//            AudioPlayerView()
//        case .settings:
//            SettingsView()
//        }
//    }
//}
//
//extension MainCoordinator {
//    @ViewBuilder
//    func goToPage(for type: PIPEContentType, with id: String) -> some View {
//        switch type {
//        case .album, .artist, .playlist, .smartTracklist, .tracklist:
//            ContainerDetailView(navigationInformation: ContainerDetailNavigator(containerId: id,
//                                                                                containerType: type,
//                                                                                isFavoriteTracks: false))
//        case .flow:
//            AudioPlayerView(container: PlayerContentType.generate(with: id, for: .flow))
//        case .livestream:
//            Text("livestream id:\(id)")
//        case .podcast:
//            Text("podcast id:\(id)")
//        case .track:
//            AudioPlayerView(container: PlayerContentType.generate(with: id, for: .track))
//        case .podcastEpisode:
//            Text("podcast episode id:\(id)")
//        }
//    }
//}
//
//enum FavoritePageType: DestinationType {
//    case artists
//    case playlists
//    case tracks
//    case albums
//    case podcasts
//}
//
//enum RelatedContentPageType: DestinationType {
//    case relatedArtists(String)
//    case artistsAlbums(String)
//}
//
//extension MainCoordinator {
//    @ViewBuilder
//    func goToPage(for type: RelatedContentPageType) -> some View {
//        switch type {
//        case let .relatedArtists(artistId):
//            GridContentView(containerId: artistId, containerType: type)
//        case let .artistsAlbums(artistId):
//            GridContentView(containerId: artistId, containerType: type)
//        }
//    }
//
//    @ViewBuilder
//    func goToPage(for type: FavoritePageType) -> some View {
//        switch type {
//        case .albums, .artists, .playlists:
//            GridContentView(containerId: nil, containerType: type)
//        case .podcasts:
//            Text("Favorite podcasts")
//        case .tracks:
//            ContainerDetailView(navigationInformation: ContainerDetailNavigator(containerId: nil,
//                                                                                containerType: nil,
//                                                                                isFavoriteTracks: true))
//        }
//    }
//}
//
//protocol DestinationType {}
//
//extension PIPEContentType: DestinationType {}
//
//// MARK: - Player navigation flow
//
//extension MainCoordinator {
//    @ViewBuilder
//    func goToPlayer(with id: String,
//                    for type: PIPEContentType,
//                    index: Int? = nil,
//                    shuffled: Bool = false,
//                    tracks: [PIPEContainerElement]? = nil) -> some View {
//        AudioPlayerView(container: PlayerContentType.generate(with: id,
//                                                              for: type,
//                                                              index: index,
//                                                              shuffled: shuffled,
//                                                              tracks: tracks))
//    }
//
//    @ViewBuilder
//    func goToPlayer(with container: PlayerContentType? = nil) -> some View {
//        AudioPlayerView(container: container)
//    }
//}
//
//extension ContainerDetailPageModel {
//    func toPlayerContentType(for index: Int? = nil,
//                             shuffled: Bool = false) -> PlayerContentType {
//        PlayerContentType.generate(with: id,
//                                   for: type,
//                                   index: index,
//                                   shuffled: shuffled,
//                                   tracks: tracks)
//    }
//}
