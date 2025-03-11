//
//  ProductQuantity.swift
//  Coffee-Kit
//
//  Created by Christoph Rohde on 06.03.25.
//

import Foundation

public struct ProductPack: Sendable, Identifiable {
    public var quantity: UInt8
    public var product: any Product
    public var id: UInt16 { product.id }
}

extension ProductPack: Codable {
    enum CodingKeys: String, CodingKey {
        case quantity
        case product
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try container.decode(UInt8.self, forKey: .quantity)
        let category = try container.decode(MenuCategory.self, forKey: .product)
        switch category {
        case .coffee:
            product = try container.decode(CoffeeModel.self, forKey: .product)
        case .cake:
            product = try container.decode(CakeModel.self, forKey: .product)
        case .tea:
            fatalError("Not implemented")
        case .snacks:
            fatalError("Not implemented")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quantity, forKey: .quantity)
        switch product.self {
        case is CoffeeModel:
            try container.encode(product as! CoffeeModel, forKey: .product)
        case is CakeModel:
            try container.encode(product as! CakeModel, forKey: .product)
        default:
            fatalError("Unknown Product Type")
        }
    }
}
