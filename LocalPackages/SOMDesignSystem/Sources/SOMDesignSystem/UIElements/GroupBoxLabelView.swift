//
//  GroupBoxLabelView.swift
//
//
//  Created by Martin Lukacs on 26/05/2023.
//

import SwiftUI

public struct GroupBoxLabelView: View {
    let labelText: String
    let labelImage: String?

    public init(labelText: String, labelImage: String?) {
        self.labelText = labelText
        self.labelImage = labelImage
    }

    public var body: some View {
        HStack {
            Text(labelText.uppercased())
                .fontWeight(.bold)
            Spacer()
            if let labelImage {
                Image(imageName: labelImage)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .scaledToFit()
            }
        }
    }
}
