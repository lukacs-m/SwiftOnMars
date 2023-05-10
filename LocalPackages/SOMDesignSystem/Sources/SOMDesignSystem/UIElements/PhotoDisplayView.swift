//
//  PhotoDisplayView.swift
//  
//
//  Created by Martin Lukacs on 22/04/2023.
//

import SwiftUI
import Kingfisher

public struct PhotoDisplayView: View {
  @Environment(\.redactionReasons) private var reasons

    public enum Size {
        case cell, detailView

        public var size: CGSize {
            switch self {
            case .cell:
                return .init(width: 300, height: 300)
            case .detailView:
                if ProcessInfo.processInfo.isiOSAppOnMac {
                    return .init(width: 48, height: 48)
                }
                return .init(width: 400, height: 400)
            }
        }
    }

  public let url: URL?
  public let size: Size

  public init(url: String, size: Size = .cell) {
    self.url = URL(string: url)
    self.size = size
  }

  public var body: some View {
    Group {
      if reasons == .placeholder {
        RoundedRectangle(cornerRadius: 10)
          .fill(.gray)
          .frame(width: size.size.width, height: size.size.height)
      } else {
          LazyImage(url: url, shouldResize: false, scaleMode: .fit)
        .frame(maxWidth: .infinity)
      }
    }
  }
}


struct LazyImage: View {
    let url: URL?
    var shouldResize = false
    var scaleMode: SwiftUI.ContentMode = .fit

    private let cacheLifeTimeDuration: StorageExpiration = .days(7)
    @State private var scale: SwiftUI.ContentMode = .fit

    var lazyImage: KFImage {
        KFImage(url)
            .resizable()
            .placeholder { _ in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
                  .frame(width: 300, height: 300)
            }
            .cancelOnDisappear(true)
            .backgroundDecode(true)
            .memoryCacheExpiration(cacheLifeTimeDuration)
            .diskCacheExpiration(cacheLifeTimeDuration)
        // in case of successful loading image
            .onSuccess({ _ in
                scale = scaleMode
            })
        // in case of failure loading image
        // .onFailure({ _ in })
    }

    var body: some View {
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
                case .fill: lazyImage.scaledToFill().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                case .fit: lazyImage.scaledToFit().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .statusBar(hidden: false)
    }
}
