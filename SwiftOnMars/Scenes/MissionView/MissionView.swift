//
//
//  MissionView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//
//

import Factory
import NasaModels
import SOMDesignSystem
import SwiftUI

struct MissionView: View {
    @StateObject private var viewModel = MissionViewModel()
    @InjectedObject(\RouterContainer.missionwRouter) private var router
    @State private var shouldExpendSearchInfos = false
    @State var initHasRun = false

    var body: some View {
        photoListView
            .overlay(alignment: .bottomTrailing) {
                searchInfosView
                    .padding([.trailing, .bottom])
            }
            .overlay(alignment: .center) {
                if viewModel.isLoadingPage, !initHasRun {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .routingProvided
            .withSheetDestinations(sheetDestinations: $router.presentedSheet)
            .navigationStackEmbeded(with: $router.path)
    }
}

private extension MissionView {
    var photoListView: some View {
        List {
            ForEach(viewModel.photos) { photo in
                PhotoListCellView(with: photo,
                                  and: .init(iconName: "heart.circle",
                                             color: viewModel.isPersisted(for: photo) ? Asset.Colors
                                                 .SecondaryColors.secondary.color : .black)) {
                    router.navigate(to: .photoDetail(photo: photo))
                } buttonTwoAction: {
                    viewModel.togglePersistantState(for: photo)
                }
                .onAppear {
                    viewModel.loadMoreContentIfNeeded(currentPhoto: photo)
                }
                .listRowSeparator(.hidden)
            }

            if viewModel.isLoadingPage, initHasRun {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }.listRowSeparator(.hidden)
            }
        }
        .refreshable {
            viewModel.fetchPhotos()
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationBarItems(trailing: navigationBarButton)
        .navigationTitle(Text("Mars Missions"))
        .navigationBarTitleDisplayMode(.large)
    }
}

private extension MissionView {
    @ViewBuilder
    var searchInfosView: some View {
        Button {
            shouldExpendSearchInfos.toggle()
        } label: {
            if shouldExpendSearchInfos {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Search Options")
                        .fontWeight(.bold)
                    Divider()
                        .overlay(Color.white)
                        .frame(width: 100)

                    sectionBuilder(title: "Rover:", text: viewModel.currentRover)
                    sectionBuilder(title: viewModel.isSolSearch ? "Sol:" : "Date:", text: viewModel.searchInfos)
                    sectionBuilder(title: "Camera:",
                                   text: "\(viewModel.currentCamera != nil ? viewModel.currentCamera ?? "" : "all")")
                }
            } else {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
        .animation(.default, value: shouldExpendSearchInfos)
        .buttonStyle(.actionButtonStyle)
    }

    @ViewBuilder
    func sectionBuilder(title: String, text: String) -> some View {
        Section(header: Text(title).fontWeight(.bold)) {
            Text(text)
        }
    }
}

private extension MissionView {
    var navigationBarButton: some View {
        Button {
            router.presentedSheet = .searchSettings
        } label: {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .foregroundColor(Asset.Colors.Main.primary.color)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
