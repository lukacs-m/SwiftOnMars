//
//  
//  MissionView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 22/04/2023.
//
//

import SwiftUI
import Factory
import NasaModels
import SOMDesignSystem

struct MissionView: View {
    @StateObject private var viewModel = MissionViewModel()
    @InjectedObject(\RouterContainer.mainRouter) private var router
    @State private var shouldExpendSearchInfos = false
    @State var initHasRun = false

    var body: some View {
        photoListView
            .overlay(alignment: .bottomTrailing) {
                searchInfosView
                    .background(.black.opacity(0.80))
                    .cornerRadius(10)
                    .padding([.trailing, .bottom])
                    .onTapGesture {
                        withAnimation {
                            shouldExpendSearchInfos.toggle()
                        }
                    }
            }
            .overlay(alignment: .center) {
                if viewModel.isLoadingPage, !initHasRun {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }.listRowSeparator(.hidden)
                }
            }
    }
}

private extension MissionView {
    var photoListView: some View {
        List {
            ForEach(viewModel.photos) { photo in
                photoListCell(with: photo)
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
        if shouldExpendSearchInfos {
            VStack(alignment: .leading, spacing: 10) {
                Text("Search Options")
                    .fontWeight(.bold)
                    Divider()
                        .overlay(Color.white)
                        .frame(width: 100)

                sectionBuilder(title: "Rover:", text: viewModel.currentRover)
                sectionBuilder(title: viewModel.isSolSearch ? "Sol:" : "Date:", text: viewModel.searchInfos)
                sectionBuilder(title: "Camera:", text: "\(viewModel.currentCamera != nil ? viewModel.currentCamera ?? "": "all")")
            }
            .buttonStyle(.plain)
            .labelStyle(.iconOnly)
            .padding()
            .foregroundColor(.white)
        } else {
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(10)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    func sectionBuilder(title: String, text: String) -> some View {
        Section(header: Text(title).fontWeight(.bold)) {
            Text(text)
        }
    }
}

private extension MissionView {
    @ViewBuilder
    var navigationBarButton: some View {
        Button {
            router.presentedSheet = .searchSettings
        } label: {
            Image(systemName: "magnifyingglass.circle").resizable() .foregroundColor(Color.black)
        }
    }
}

private extension MissionView {
    @ViewBuilder
    func photoListCell(with photo: Photo) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Button {
                router.navigate(to: .missionDetail(id: photo.imgSrc))
            } label: {
                PhotoDisplayView(url: photo.imgSrc)
                    .onAppear {
                        viewModel.loadMoreContentIfNeeded(currentPhoto: photo)
                    }
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .shadow(radius: 5)
            }
            .buttonStyle(.borderless)

            Button {
                viewModel.togglePersistantState(for: photo)
            } label: {
               Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .foregroundColor(viewModel.isPersisted(for: photo) ? .red : .black)
            }
            .background(.white.opacity(0.75))
            .cornerRadius(5)
            .padding()
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
