//
//  DelayAppearanceModifier.swift
//  
//
//  Created by Martin Lukacs on 22/05/2023.
//

import SwiftUI

public struct DelayAppearanceModifier: ViewModifier {
    @State var shouldDisplay = false

    let delay: TimeInterval

    public func body(content: Content) -> some View {
        render(content)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.shouldDisplay = true
                }
            }
    }

    @ViewBuilder
    private func render(_ content: Content) -> some View {
        if shouldDisplay {
            content
        } else {
            content
                .hidden()
        }
    }
}

public extension View {
    func delayAppearance(bySeconds seconds: Double) -> some View {
        modifier(DelayAppearanceModifier(delay: seconds))
    }
}
