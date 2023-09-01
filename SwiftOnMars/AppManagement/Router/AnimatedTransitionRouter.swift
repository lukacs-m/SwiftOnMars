//
//  AnimatedTransitionRouter.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 29/05/2023.
//

import SwiftUI

@MainActor
final class AnimatedTransitionRouter {
    @ViewBuilder
    func animatedRouting(for destination: RouterDestination,
                         isShowingDetail: Binding<Bool>,
                         animationNamespace: Namespace.ID) -> some View {
        switch destination {
        case let .favoritePhotoDetail(photo):
            DetailView(viewModel: DetailViewModel(photo: photo))
        default:
            Text("Not implemented Yet")
        }
    }
}
