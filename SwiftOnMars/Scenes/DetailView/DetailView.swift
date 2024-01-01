//
//
//  DetailView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 25/05/2023.
//
//

import Factory
import NasaModels
import SimpleToast
import SOMDesignSystem
import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var toastToDisplay: SimpleToast?

    var body: some View {
        VStack {
            topImageView
            informationScrollview
            Spacer()
        }
        .ignoresSafeArea(edges: [.horizontal])
        .navigationTitle("Photo " + String(viewModel.photo.id))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.photoIsPersisted) {
            let title = viewModel.photoIsPersisted ? "The photo was added to your favorites" :
                "The photo was just removed from your favorites"
            let type: ToastType = viewModel.photoIsPersisted ? .complete(.green) : .error(.orange)
            toastToDisplay = SimpleToast(displayMode: .bottom(.pop),
                                         type: type,
                                         title: title,
                                         style: ToastStyle(backgroundColor: .gray))
        }
        .toast(toast: $toastToDisplay)
    }
}

private extension DetailView {
    var topImageView: some View {
        ZStack(alignment: .bottom) {
            LazyImage(url: viewModel.photo.imageUrl, scaleMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()

            VStack {
                HStack {
                    Spacer()
                    ToggleFavortiteButton(with: .favDefault(isPersisted: viewModel.photoIsPersisted),
                                          action: viewModel.togglePhotoPersistantState)
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
        GroupBox(label: GroupBoxLabelView(labelText: "Camera", labelImage: nil)) {
            GroupBoxRowView(name: "Id", content: "\(viewModel.photo.camera.id)")
            GroupBoxRowView(name: "Name", content: viewModel.photo.camera.name)
            GroupBoxRowView(name: "Description", content: viewModel.photo.camera.fullName)
        }
    }
}

private extension DetailView {
    var roverInfoBox: some View {
        GroupBox(label: GroupBoxLabelView(labelText: "Rover",
                                          labelImage: viewModel.photo.rover.name)) {
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
