//
//  
//  FavoriteView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 10/05/2023.
//
//

import NasaModels
import SwiftUI
import SOMDesignSystem

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()

    var body: some View {
        NavigationStack {
            photoListView
            
                .onDisappear {
                    viewModel.persist()
                }
                .navigationTitle(Text("Mars Souvenirs"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        toolbarMenu
                    }
                }
        }
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
            ForEach(viewModel.photos) { photo in
                DetailPhotoListCellView(with: photo)
            }
            .onDelete { offsets in
                viewModel.remove(at:offsets)
            }
        }
        .listStyle(.plain)
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
