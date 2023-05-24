//
//  Button+Styles.swift
//  
//
//  Created by Martin Lukacs on 13/05/2023.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(.white)
            .background(Asset.Colors.Main.primaryDarkest.color)
            .cornerRadius(10)
    }
}

public extension ButtonStyle where Self == ActionButtonStyle {
    static var actionButtonStyle: ActionButtonStyle {
        ActionButtonStyle()
    }
}
