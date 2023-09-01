//
//
//  FavoriteView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 10/05/2023.
//
//

import Factory
import NasaModels
import SOMDesignSystem
import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @Namespace private var animationSpace
    @State private var isShowingDetailedScreen = false
    @State private var dismissInfos = false

    @InjectedObject(\RouterContainer.mainRouter) private var router

    var body: some View {
        photoListView
            .onDisappear {
                viewModel.persist()
            }
            .navigationTitle(Text("Mars Souvenirs"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    displayOptions
                }
            }
            .routingProvided
            .navigationStackEmbeded(with: $router.path)
    }
}

private extension FavoriteView {
    @ViewBuilder
    var photoListView: some View {
        if viewModel.photos.isEmpty {
            emptyView
                .delayAppearance(bySeconds: 1)
        } else {
            listOfFavoriteView
        }
    }
}

private extension FavoriteView {
    var emptyView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Label("You have not favorites yet.",
                      systemImage: "exclamationmark.triangle.fill")
                Spacer()
            }
            Spacer()
        }
    }
}

private extension FavoriteView {
    var listOfFavoriteView: some View {
        List {
            ForEach(viewModel.photos.keys.sorted(by: <), id: \.self) { key in
                Section(header: Text(key).bold().padding(.bottom, 10)) {
                    ForEach(viewModel.photos[key] ?? []) { photo in
                        Button {
                            router.navigate(to: .photoDetail(photo: photo))
                        } label: {
                            DetailPhotoListCellView(with: photo,
                                                    namespace: animationSpace)
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
        .listStyle(.plain)
    }
}

private extension FavoriteView {
    @ViewBuilder
    var displayOptions: some View {
        toolbarMenu.opacity(viewModel.selectedPhoto != nil ? 0 : 1)
    }
}

private extension FavoriteView {
    var toolbarMenu: some View {
        Menu {
            ForEach(PhotoFilterSelection.allCases, id: \.self) { filterSelection in
                Button {
                    viewModel.filter(by: filterSelection)
                } label: {
                    if viewModel.currentFilter == filterSelection {
                        Label(filterSelection.title, systemImage: "checkmark.circle")
                    } else {
                        Text(filterSelection.title)
                    }
                }
            }
        } label: {
            Image(systemName: "camera.filters")
                .imageScale(.large)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
