//
//  
//  DetailView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 25/05/2023.
//
//

import SwiftUI
import NasaModels
import SOMDesignSystem
import Factory

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @InjectedObject(\RouterContainer.mainRouter) private var router

    var body: some View {
        VStack() {
            topImageView
            informationScrollview
            Spacer()
        }
        .ignoresSafeArea(edges: [.horizontal])
        .navigationTitle("Photo " + String(viewModel.photo.id))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailView {
    var topImageView: some View {
        ZStack(alignment: .bottom) {
            LazyImage(url:viewModel.photo.imageUrl, scaleMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()

            VStack {
                HStack {
                    Spacer()
                    ToggleFavortiteButton(with: .favDefault(isPersisted: viewModel.photoIsPersisted),
                                          action:  viewModel.togglePhotoPersistantState)

                }
                Spacer()
            }

            HStack {
                Text("Days since **landing**: \(viewModel.photo.sol)")
                Spacer()
                Text("\(viewModel.photo.earthDate)")
            }.foregroundColor(.black)
                .padding(10)
                .background(.white.opacity(0.5))
                .cornerRadius(10)
                .padding(10)
        }
    }
}

private extension DetailView {
    var informationScrollview: some View {
        ScrollView {
            VStack(alignment: .leading) {
                cameraInfoBox
                roverInfoBox
            }
            .padding()
        }
    }
}

private extension DetailView {
    var cameraInfoBox: some View {
        GroupBox(
            label: GroupBoxLabelView(labelText: "Camera", labelImage: "info.circle")
        ){
            GroupBoxRowView(name: "Id", content: "\(viewModel.photo.camera.id)")
            GroupBoxRowView(name: "Name", content: viewModel.photo.camera.name)
            GroupBoxRowView(name: "Description", content: viewModel.photo.camera.fullName)
        }
    }
}

private extension DetailView {
    var roverInfoBox: some View {
        GroupBox(
            label: GroupBoxLabelView(labelText: "Rover",
                                     labelImage: viewModel.photo.rover.name)
        ){
            GroupBoxRowView(name: "Id", content: "\(viewModel.photo.rover.id)")
            GroupBoxRowView(name: "Name", content: viewModel.photo.rover.name)
            GroupBoxRowView(name: "Landing date", content: viewModel.photo.rover.landingDate)
            GroupBoxRowView(name: "Launch date", content: viewModel.photo.rover.launchDate)
            GroupBoxRowView(name: "Status", content: viewModel.photo.rover.status)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(photo: Photo.mocked))
    }
}
