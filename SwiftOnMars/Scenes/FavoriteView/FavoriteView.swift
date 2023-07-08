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
import Factory

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @Namespace private var animationSpace
    @State private var isShowingDetailedScreen = false
    @State private var isSource = false
    @State private var dismissInfos = false

    @InjectedObject(\RouterContainer.mainRouter) private var router


    let animationDuration =  0.3//3.0  //0.4 //

    var body: some View {
//        NavigationStack {
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
//        }
//        .overlay {
//            showDetailView
//        }
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
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.photos) { photo in
//                    if photo.id == viewModel.selectedPhoto?.id {
//                        Color.clear.frame(height: 100)
//                    } else {
//                        DetailPhotoListCellView(with: photo, namespace: animationSpace, isSource: !isSource)
//                            .frame(height: 100)
//                            .padding(.horizontal)
//                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: animationDuration)) {
//                                    viewModel.toggleSelection(for: photo)
//                                    dismissInfos = false
//                                }
//                            }
//                    }
//                }
//                .onDelete { offsets in
//                    viewModel.remove(at: offsets)
//                }
//            }
//        }


        List {
            ForEach(viewModel.photos.keys.sorted(by: <), id: \.self) { key in
                Section(header: Text(key).bold().padding(.bottom, 10)) {
                    ForEach(viewModel.photos[key] ?? []) { photo in
                        Button {
                            router.navigate(to: .photoDetail(photo: photo))
                        } label: {
                            DetailPhotoListCellView(with: photo,
                                                    namespace: animationSpace,
                                                    isSource: !isSource)
                            .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
        //                PhotoListCellView(with: photo,
        //                                  and: .init(iconName: "heart.circle",
        //                                             color: Asset.Colors.SecondaryColors.secondary.color )) {
        //                    router.navigate(to: .photoDetail(photo: photo))
        //                } buttonTwoAction: {
        ////                    viewModel.togglePersistantState(for: photo)
        //                }
        //                .onAppear {
        //                    viewModel.loadMoreContentIfNeeded(currentPhoto: photo)
        //                }
                        .listRowSeparator(.hidden)
                        //   .listRowInsets(EdgeInsets())
                        //   .padding(.bottom, 10)
                    }
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
            }

//            ForEach(viewModel.photos) { photo in
//                Button {
//                    router.navigate(to: .photoDetail(photo: photo))
//                } label: {
//                    DetailPhotoListCellView(with: photo,
//                                            namespace: animationSpace,
//                                            isSource: !isSource)
//                    .cornerRadius(10)
//                }
//                .buttonStyle(.plain)
////                PhotoListCellView(with: photo,
////                                  and: .init(iconName: "heart.circle",
////                                             color: Asset.Colors.SecondaryColors.secondary.color )) {
////                    router.navigate(to: .photoDetail(photo: photo))
////                } buttonTwoAction: {
//////                    viewModel.togglePersistantState(for: photo)
////                }
////                .onAppear {
////                    viewModel.loadMoreContentIfNeeded(currentPhoto: photo)
////                }
//                .listRowSeparator(.hidden)
//                //   .listRowInsets(EdgeInsets())
//                //   .padding(.bottom, 10)
//            }
//            .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
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
//
//private extension FavoriteView {
//    @ViewBuilder
//    private var showDetailView: some View {
//        if let photo = viewModel.selectedPhoto {
//            FavoriteDetailView(viewModel: FavoriteDetailViewModel(photo: photo),
//                               animationNamespace: animationSpace,
//                               animationDuration: animationDuration,
//                               dismiss: $dismissInfos)
//            .onChange(of: dismissInfos) { value in
//                guard value else {
//                    return
//                }
//                withAnimation(.easeIn(duration: animationDuration)) {
//                    viewModel.toggleSelection()
//                }
//            }
//
////                .onTapGesture {
//////                    showInfos = false
////                    withAnimation(.easeIn(duration: animationDuration)) {
////                        viewModel.toggleSelection()
////                    }
////                }
//
////                .onDisappear {
////                    viewModel.toggleSelection()
////
////                }
//        } else {
//            EmptyView()
//        }
//    }
//}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}




//#########################
//
//struct FavoriteView: View {
//    @StateObject private var viewModel = FavoriteViewModel()
//    @Namespace private var animationSpace
//    @State private var isShowingDetailedScreen = false
//    @State private var isSource = false
//    @State private var dismissInfos = false
//
//    let animationDuration =  0.3//3.0  //0.4 //
//
//    var body: some View {
//        NavigationStack {
//            photoListView
//                .onDisappear {
//                    viewModel.persist()
//                }
//                .navigationTitle(Text("Mars Souvenirs"))
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        displayOptions
//                    }
//                }
//        }
//        .overlay {
//            showDetailView
//        }
//    }
//}
//
//private extension FavoriteView {
//    @ViewBuilder
//    var photoListView: some View {
//        if viewModel.photos.isEmpty {
//            emptyView
//                .delayAppearance(bySeconds: 1)
//        } else {
//            listOfFavoriteView
//        }
//    }
//}
//
//private extension FavoriteView {
//    var emptyView: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                Label("You have not favorites yet.",
//                      systemImage: "exclamationmark.triangle.fill")
//                Spacer()
//            }
//            Spacer()
//        }
//    }
//}
//
//private extension FavoriteView {
//    var listOfFavoriteView: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.photos) { photo in
//                    if photo.id == viewModel.selectedPhoto?.id {
//                        Color.clear.frame(height: 100)
//                    } else {
//                        DetailPhotoListCellView(with: photo, namespace: animationSpace, isSource: !isSource)
//                            .frame(height: 100)
//                            .padding(.horizontal)
//                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: animationDuration)) {
//                                    viewModel.toggleSelection(for: photo)
//                                    dismissInfos = false
//                                }
//                            }
//                    }
//                }
//                .onDelete { offsets in
//                    viewModel.remove(at: offsets)
//                }
//            }
//        }
//    }
//}
//
//private extension FavoriteView {
//    @ViewBuilder
//    var displayOptions: some View {
//        toolbarMenu.opacity(viewModel.selectedPhoto != nil ? 0 : 1)
//    }
//}
//
//
//private extension FavoriteView {
//    var toolbarMenu: some View {
//        Menu {
//            ForEach(PhotoFilterSelection.allCases, id: \.self) { filterSelection in
//                Button {
//                    viewModel.filter(by: filterSelection)
//                } label: {
//                    if viewModel.currentFilter == filterSelection {
//                        Label(filterSelection.title, systemImage: "checkmark.circle")
//                    } else {
//                        Text(filterSelection.title)
//                    }
//                }
//            }
//        } label: {
//            Image(systemName: "camera.filters")
//                .imageScale(.large)
//        }
//    }
//}
//
//private extension FavoriteView {
//    @ViewBuilder
//    private var showDetailView: some View {
//        if let photo = viewModel.selectedPhoto {
//            FavoriteDetailView(viewModel: FavoriteDetailViewModel(photo: photo),
//                               animationNamespace: animationSpace,
//                               animationDuration: animationDuration,
//                               dismiss: $dismissInfos)
//            .onChange(of: dismissInfos) { value in
//                guard value else {
//                    return
//                }
//                withAnimation(.easeIn(duration: animationDuration)) {
//                    viewModel.toggleSelection()
//                }
//            }
//
////                .onTapGesture {
//////                    showInfos = false
////                    withAnimation(.easeIn(duration: animationDuration)) {
////                        viewModel.toggleSelection()
////                    }
////                }
//
////                .onDisappear {
////                    viewModel.toggleSelection()
////
////                }
//        } else {
//            EmptyView()
//        }
//    }
//}
//
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}
//
