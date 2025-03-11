//
//  Product.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public protocol Product: Identifiable, Sendable, Codable, CustomDebugStringConvertible, Hashable {
    var id: UInt16 { get }
    var name: String { get }
    var price: Float64 { get }
    var metadata: Metadata { get }
    var debugDescription: String { get }
    var menuCategory: MenuCategory { get }
}

public extension Product {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(metadata)
    }
}
