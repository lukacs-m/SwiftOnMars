//
//  PhotoListCellView.swift
//  
//
//  Created by Martin Lukacs on 10/05/2023.
//

import NasaModels
import SwiftUI
import Kingfisher

public struct IconConfig {
    let iconName: String
    let color: Color

    public init(iconName: String, color: Color) {
        self.iconName = iconName
        self.color = color
    }

    public static func favDefault(isPersisted: Bool) -> IconConfig {
        .init(iconName: "heart.circle", color: isPersisted ? Asset.Colors.SecondaryColors.secondary.color : .black)
    }
}

public struct PhotoListCellView: View {
    private let photo: Photo
    private let iconConfig: IconConfig
    private let buttonOneAction: @MainActor () -> Void
    private let buttonTwoAction: @MainActor () -> Void
    @State private var hide = true

    public init(with photo: Photo,
                and iconConfig: IconConfig,
                buttonOneAction: @MainActor @escaping () -> Void = {},
                buttonTwoAction: @MainActor @escaping () -> Void) {
        self.photo = photo
        self.iconConfig = iconConfig
        self.buttonOneAction = buttonOneAction
        self.buttonTwoAction = buttonTwoAction
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Button {
                buttonOneAction()
            } label: {
                KFImage(photo.imageUrl)
                    .resizable()
                    .placeholder { _ in
                        ProgressView()
                    }
                    .fade(duration: 0.25)
                    .cancelOnDisappear(true)
                    .backgroundDecode(true)
                    .onSuccess { _ in
                        hide = false
                    }
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .shadow(radius: 5)
            }
            .buttonStyle(.borderless)

            ToggleFavortiteButton(with: iconConfig, action: buttonTwoAction)
                .opacity(hide ? 0 : 1)
        }
    }
}


