//
//  GroupBoxRowView.swift
//  
//
//  Created by Martin Lukacs on 26/05/2023.
//

import SwiftUI

public struct GroupBoxRowView: View {
    let name: String
    let content: String?
    let linkLabel: String?
    let linkDestination: String?

    public init(name: String, content: String? = nil, linkLabel: String? = nil, linkDestination: String? = nil) {
        self.name = name
        self.content = content
        self.linkLabel = linkLabel
        self.linkDestination = linkDestination
    }

    public var body: some View {
        VStack {
            Divider().padding(.vertical, 4)

            HStack {
                Text(name).foregroundColor(Color.gray)
                Spacer()
                if (content != nil) {
                    Text(content!)
                } else if let linkLabel, let linkDestination, let url = URL(string: "https://\(linkDestination)")  {
                    Link(linkLabel, destination: url)
                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                } else {
                    EmptyView()
                }
            }
        }
    }
}
