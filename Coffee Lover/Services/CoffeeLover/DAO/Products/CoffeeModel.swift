//
//  CoffeeMenu.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public struct CoffeeModel: Product, Codable, Hashable {
    public let id: UInt16
    public let name: String
    public let price: Float64
    public let metadata: Metadata

    public static func == (lhs: CoffeeModel, rhs: CoffeeModel) -> Bool {
        lhs.id == rhs.id
    }
}
