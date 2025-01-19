//
//  Product.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public protocol Product: Identifiable, Sendable, Codable, CustomDebugStringConvertible {
    var id: UInt16 { get }
    var name: String { get }
    var price: Float64 { get }
    var metadata: Metadata { get }
    var debugDescription: String { get }
}

