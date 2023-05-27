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

    public init(with photo: Photo) {
        self.photo = photo
    }

    public var body: some View {
        HStack {
            lazyImage
                .scaledToFill()
                .frame(width: 75, height: 75)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(verbatim: "Photo \(photo.id)")
                Text(photo.rover.name)
                    .font(.caption)
                          .foregroundStyle(.secondary)
                Text("\(photo.camera.name)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Sol: \(photo.sol)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(imageName: photo.rover.name)
                .resizable()
                .frame(width: 35, height: 35)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
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
