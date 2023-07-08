//
//  
//  FavoriteDetailView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 27/05/2023.
//
//

import SwiftUI
import NasaModels
import SOMDesignSystem

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
                    .mask(RoundedRectangle(cornerRadius: 0, style:.continuous)     .matchedGeometryEffect(id: "mask\(viewModel.photo.id)", in: animationNamespace))

//                Spacer()
                VStack() {

                    VStack(alignment: .leading, spacing: 8) {
                        Text(verbatim: "Photo \(viewModel.photo.id)")
//                            .font(.title.bold())
                            .animatableSystemFont(size: 22 , weight: .bold)
//                            .transition(.scale)
//                            .animatableSystemFont(size: 22 , weight: .bold)
                            .minimumScaleFactor(0.2)
                            .matchedGeometryEffect(id: "infostitle\(viewModel.photo.id)", in: animationNamespace)

//                            .frame(minWidth: 150, maxWidth: .infinity, alignment: .leading)
//                            .frame(minWidth: 250, maxWidth: .infinity, alignment: .leading)

                        Text("Camera: \(viewModel.photo.camera.name)")
//                            .font(.body)
                            .animatableSystemFont(size: 15)
                            .minimumScaleFactor(0.2)

                            .matchedGeometryEffect(id: "camera\(viewModel.photo.id)", in: animationNamespace)
                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        Text(verbatim: "Sol: \(viewModel.photo.sol)")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                            .matchedGeometryEffect(id: "sol\(viewModel.photo.id)", in: animationNamespace)
//                            .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .matchedGeometryEffect(id: "infos\(viewModel.photo.id)",  in: animationNamespace)
//                    .fixedSize(horizontal: true, vertical: false)
//
                    .padding(10)
//                    .background(Asset.Colors.Backgrounds.lightestGray.color)
////                    .cornerRadius(5)
//
                    HStack {
                        Image(imageName: viewModel.photo.rover.name)
                            .resizable()
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 2)
                            )
                            .matchedGeometryEffect(id: "roverImage\(viewModel.photo.id)",  in: animationNamespace)
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
//                Spacer()
            }
            .ignoresSafeArea()

//            .transition(.identity)
//            .padding()
//            .background(.blue)
//            .matchedGeometryEffect(id: "container\(viewModel.photo.id)", in: animationSpace)

        }
        .ignoresSafeArea()
        .padding()

//        .background(.blue)
//        .background(Material.ultraThinMaterial.matchedGeometryEffect(id: "background\(viewModel.photo.id)", in: animationSpace))

      .background {
          VisualEffectView(effect: UIBlurEffect(style: .light))
              .matchedGeometryEffect(id: "background\(viewModel.photo.id)", in: animationNamespace)
//            Material.ultraThinMaterial
//                .matchedGeometryEffect(id: "background\(viewModel.photo.id)", in: animationSpace)
//            .ultraThinMaterial
//
        }
      .offset(offset)
      .offset(y: offset.height * -0.7)
      .scaleEffect(scale)
      .gesture(
          DragGesture()
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
                  }
                  else {
                      withAnimation(.easeInOut(duration: 0.25)) {
                          offset = .zero
                      }
                  }
//                  if abs(offset.width) > 150 || abs(offset.height) > 150  {
//                      withAnimation(.easeIn(duration: animationDuration)) {
//                          self.dismiss = true
//                          offset = .zero
//                      }
//                  } else {
//                      withAnimation {
//                          offset = .zero
//                      }
//                  }
              }
      )
//        .matchedGeometryEffect(id: "container\(viewModel.photo.id)", in: animationSpace)
        .onAppear {
//            withAnimation(.easeOut(duration: animationDuration + 0.4)) {
//                showInfos = true
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration - 0.3) {
                withAnimation {
                    showInfos = true
                }
            }
        }


//        .onDisappear {
//            withAnimation {
//                showInfos = true
//            }
////            showInfos = false
//        }
//        .onTapGesture {
//            showInfos = false
//            withAnimation(.easeIn(duration: animationDuration)) {
//                viewModel.toggleSelection()
//            }
//        }
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
                           animationNamespace: namespace, animationDuration: 4,
                           dismiss: $isShoving)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

//struct AnimatableSystemFontModifier: ViewModifier, Animatable {
//    var size: Double
//    var weight: Font.Weight
//    var design: Font.Design
//
//    var animatableData: Double {
//        get { size }
//        set { size = newValue }
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: size, weight: weight, design: design))
//    }
//}
//
//extension View {
//    func animatableSystemFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
//        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
//    }
//}
