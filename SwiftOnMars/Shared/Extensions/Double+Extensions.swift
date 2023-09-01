//
//  Double+Extensions.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 01/05/2023.
//

import Foundation

extension Double {
    var toInt: Int {
        Int(self)
    }

    var toRoundedDescription: String {
        "\(Int(self))"
    }
}
