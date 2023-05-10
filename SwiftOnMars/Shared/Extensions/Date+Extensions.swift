//
//  Date+Extensions.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 30/04/2023.
//

import Foundation

extension Date {
    var toEarthDateDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return  dateFormatter.string(from: self)
    }
}
