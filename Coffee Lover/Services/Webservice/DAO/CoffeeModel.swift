//
//  CoffeeMenu.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public struct CoffeeModel: Product, Codable, Sendable {
    public let id: UUID
    public let productNumber: UInt16
    public let name: String
    public let price: Float64
}
