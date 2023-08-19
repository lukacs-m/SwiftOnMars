//
//  DetailPhotoListCellView.swift
//  
//
//  Created by Martin Lukacs on 22/05/2023.
//

import Kingfisher
import NasaModels
import SwiftUI

public struct DetailPhotoListCellView: View {
    private let photo: Photo
    private let animationNamespace: Namespace.ID

    public init(with photo: Photo, namespace: Namespace.ID) {
        self.photo = photo
        self.animationNamespace = namespace
    }

    public var body: some View {
        HStack {
            lazyImage
                .matchedGeometryEffect(id: "test\(photo.id)",  in: animationNamespace)
                .scaledToFill()
                .frame(width: 75, height: 75)
                .mask(RoundedRectangle(cornerRadius: 10, style:.continuous)
                    .matchedGeometryEffect(id: "mask\(photo.id)", in: animationNamespace))
            Spacer()

            VStack(alignment: .leading) {
                Text(verbatim: "Photo \(photo.id)")
                    .animatableSystemFont(size: 15)
                    .matchedGeometryEffect(id: "infostitle\(photo.id)", in: animationNamespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.scale)
                Text(photo.rover.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(photo.camera.name)")
                    .animatableSystemFont(size: 13)
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: "camera\(photo.id)", in: animationNamespace)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Sol: \(photo.sol)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: "sol\(photo.id)", in: animationNamespace)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .matchedGeometryEffect(id: "infos\(photo.id)",  in: animationNamespace)

            Spacer()
            Image(imageName: photo.rover.name)
                .resizable()
                .cornerRadius(17.5)
                .matchedGeometryEffect(id: "roverImage\(photo.id)",  in: animationNamespace)
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fill)
        }
        .padding(10)
        .background {
            Asset.Colors.Backgrounds.lightestGray.color
                .matchedGeometryEffect(id: "background\(photo.id)", in: animationNamespace)

        }
    }

    private var lazyImage: KFImage {
        KFImage(photo.imageUrl)
            .resizable()
            .fade(duration: 0.25)
            .cancelOnDisappear(true)
            .backgroundDecode(true)
    }
}

struct FavoriteDetailView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        DetailPhotoListCellView(with: Photo.mocked, namespace: namespace)
    }
}

public struct AnimatableSystemFontModifier: ViewModifier, Animatable {
    public var size: Double
    public var weight: Font.Weight
    public var design: Font.Design

    public var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    public func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

public extension View {
     func animatableSystemFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
