//
//  PhotoDisplayView.swift
//
//
//  Created by Martin Lukacs on 22/04/2023.
//

import Kingfisher
import SwiftUI

public struct PhotoDisplayView: View {
    @Environment(\.redactionReasons) private var reasons

    public enum Size {
        case cell

        public var size: CGSize {
            switch self {
            case .cell:
                return .init(width: 300, height: 300)
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
