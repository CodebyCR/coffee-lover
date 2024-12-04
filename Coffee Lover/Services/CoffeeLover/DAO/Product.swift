//
//  Product.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public protocol Product: Sendable {
    var id: UUID { get }
    var productNumber: UInt16 { get }
    var name: String { get }
    var price: Float64 { get }
}
