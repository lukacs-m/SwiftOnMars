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

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel

    var body: some View {
        VStack() {
            topImageView
            informationScrollview
            Spacer()
        }
        .ignoresSafeArea(edges: [.horizontal])
        .navigationTitle("Photo \(viewModel.photo.id)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailView {
    var topImageView: some View {
        ZStack(alignment: .bottom) {
            LazyImage(url:viewModel.photo.imageUrl, scaleMode: .fill)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: [.horizontal])

            HStack {
                Text("Days on Mars: \(viewModel.photo.sol)")
                Spacer()
                Text("\(viewModel.photo.earthDate)")
            }.foregroundColor(.white)
                .padding()
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
        }
    }
}

private extension DetailView {
    var roverInfoBox: some View {
        GroupBox(
            label: GroupBoxLabelView(labelText: "Rover", labelImage: "info.circle")
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
