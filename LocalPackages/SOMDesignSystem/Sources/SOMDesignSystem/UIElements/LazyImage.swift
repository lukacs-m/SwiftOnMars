//
//  LazyImage.swift
//
//
//  Created by Martin Lukacs on 26/05/2023.
//

import Kingfisher
import SwiftUI

public struct LazyImage: View {
    public let url: URL?
    public var shouldResize = false
    public var scaleMode: SwiftUI.ContentMode = .fit

    private let cacheLifeTimeDuration: StorageExpiration = .days(7)
    @State private var scale: SwiftUI.ContentMode = .fit

    public init(url: URL? = nil, shouldResize: Bool = false, scaleMode: SwiftUI.ContentMode = .fit) {
        self.url = url
        self.shouldResize = shouldResize
        self.scaleMode = scaleMode
    }

    var lazyImage: KFImage {
        KFImage(url)
            .resizable()
            .placeholder { _ in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .fade(duration: 0.25)
            .cancelOnDisappear(true)
            .backgroundDecode(true)
            .memoryCacheExpiration(cacheLifeTimeDuration)
            .diskCacheExpiration(cacheLifeTimeDuration)
            .onSuccess { _ in
                scale = scaleMode
            }
    }

    public var body: some View {
        ZStack {
            if shouldResize {
                GeometryReader { reader in
                    switch scale {
                    case .fill: lazyImage.setProcessor(DownsamplingImageProcessor(size: reader.size))
                        .scaledToFill().frame(maxWidth: .infinity, alignment: .center)

                    case .fit: lazyImage.setProcessor(DownsamplingImageProcessor(size: reader.size))
                        .scaledToFit().frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            } else {
                switch scale {
                case .fill:
                    lazyImage
                        .scaledToFill()
                case .fit:
                    lazyImage
                        .scaledToFit()
                }
            }
        }
        .statusBar(hidden: false)
    }
}
