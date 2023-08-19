//
//
//  FavoriteDetailView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 27/05/2023.
//
//

import NasaModels
import SOMDesignSystem
import SwiftUI

struct FavoriteDetailView: View {
    @StateObject var viewModel: FavoriteDetailViewModel
    let animationNamespace: Namespace.ID
    @State private var showInfos = false
    let animationDuration: CGFloat
    @Binding var dismiss: Bool

    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Capsule()
                        .foregroundColor(Asset.Colors.Backgrounds.darkGray.color)
                        .frame(width: 45, height: 3)
                    Spacer()
                }
                .opacity(showInfos ? 1 : 0)
                .padding(.bottom)
                LazyImage(url: viewModel.photo.imageUrl, scaleMode: .fit)
                    .matchedGeometryEffect(id: "test\(viewModel.photo.id)", in: animationNamespace)
                    .frame(maxWidth: .infinity)
                    .mask(RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .matchedGeometryEffect(id: "mask\(viewModel.photo.id)",
                                               in: animationNamespace))

                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(verbatim: "Photo \(viewModel.photo.id)")
                            .animatableSystemFont(size: 22, weight: .bold)
                            .minimumScaleFactor(0.2)
                            .matchedGeometryEffect(id: "infostitle\(viewModel.photo.id)", in: animationNamespace)

                        Text("Camera: \(viewModel.photo.camera.name)")
                            .animatableSystemFont(size: 15)
                            .minimumScaleFactor(0.2)

                            .matchedGeometryEffect(id: "camera\(viewModel.photo.id)", in: animationNamespace)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .matchedGeometryEffect(id: "infos\(viewModel.photo.id)", in: animationNamespace)
                    .padding(10)

                    HStack {
                        Image(imageName: viewModel.photo.rover.name)
                            .resizable()
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 2))
                            .matchedGeometryEffect(id: "roverImage\(viewModel.photo.id)", in: animationNamespace)
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                        //
                        VStack(alignment: .leading) {
                            Text(viewModel.photo.rover.name)
                                .font(.title2)
                            Spacer()
                            Text("*Earth Launch*: \(viewModel.photo.rover.launchDate)")
                                .font(.body)
                            Text("***Mars landing***: \(viewModel.photo.rover.landingDate)")
                                .font(.body)
                            Spacer()
                        }.opacity(showInfos ? 1 : 0)
                            .frame(width: 150, height: 150)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .padding()

        .background {
            VisualEffectView(effect: UIBlurEffect(style: .light))
                .matchedGeometryEffect(id: "background\(viewModel.photo.id)", in: animationNamespace)
        }
        .offset(offset)
        .offset(y: offset.height * -0.7)
        .scaleEffect(scale)
        .gesture(DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { value in
                if value.translation.height > 200 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        showInfos = false
                    }

                    withAnimation(.easeIn(duration: 0.3)) {
                        offset = .zero
                        dismiss = true
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        offset = .zero
                    }
                }
            })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration - 0.3) {
                withAnimation {
                    showInfos = true
                }
            }
        }
    }

    var scale: CGFloat {
        var yOffset = offset.height
        yOffset = yOffset < 0 ? 0 : yOffset
        var progress = yOffset / UIScreen.main.bounds.size.height
        progress = 1 - (progress > 0.4 ? 0.4 : progress)
        return showInfos ? progress : 1
    }
}

struct FavoriteDetailView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        @State var isShoving = false

        FavoriteDetailView(viewModel: FavoriteDetailViewModel(photo: Photo.mocked),
                           animationNamespace: namespace,
                           animationDuration: 4,
                           dismiss: $isShoving)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
