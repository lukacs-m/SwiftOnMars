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
        photoListView
            .onDisappear {
                viewModel.persist()
            }
            .navigationTitle(Text("Mars Souvenirs"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
    }
}

private extension FavoriteView {
    @ViewBuilder
    var photoListView: some View {
        if viewModel.photos.isEmpty {
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
        } else {
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
}



struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
