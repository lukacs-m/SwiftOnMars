//
//  ToggleFavortiteButton.swift
//  
//
//  Created by Martin Lukacs on 26/05/2023.
//

import SwiftUI

public struct ToggleFavortiteButton: View {
    private let action: @MainActor () -> Void
    private let iconConfig: IconConfig

    public init(with iconConfig: IconConfig,
                action: @MainActor @escaping () -> Void = {}) {
        self.iconConfig = iconConfig
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconConfig.iconName)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(5)
                .foregroundColor(iconConfig.color)
        }
        .background(Asset.Colors.Backgrounds.lighterGray.color)
        .cornerRadius(5)
        .padding(.all, Sizes.Paddings.base)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ToggleFavortiteButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleFavortiteButton(with: IconConfig(iconName: "heart", color: .blue))
    }
}
