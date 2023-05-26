//
//  File.swift
//  
//
//  Created by Martin Lukacs on 25/05/2023.
//

import Foundation

public protocol Mockable {

   static var mocked: Self { get }
}
