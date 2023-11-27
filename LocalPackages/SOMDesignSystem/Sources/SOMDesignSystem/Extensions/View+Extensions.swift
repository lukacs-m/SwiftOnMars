//
//  View+Extensions.swift
//
//
//  Created by Martin Lukacs on 23/04/2023.
//

import SwiftUI

public extension View {
    @MainActor @ViewBuilder
    func navigationStackEmbeded(with path: Binding<NavigationPath>) -> some View {
        NavigationStack(path: path) {
            self
        }
    }
}
