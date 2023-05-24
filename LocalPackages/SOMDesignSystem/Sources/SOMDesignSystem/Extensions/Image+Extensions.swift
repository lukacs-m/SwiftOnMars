//
//  Image+Extensions.swift
//  
//
//  Created by Martin Lukacs on 13/05/2023.
//

import SwiftUI

public extension Image {
    init(imageName name: String) {
        self.init(name, bundle: .module)
    }
}
