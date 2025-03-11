//
//  Order.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct Order: Identifiable, Sendable {
    public let id: UUID
    public let userId: UUID
    public let timestamp: Date
    public let products: [ProductPack]
    public let totalPrice: Float64
    public let paymentOption: PaymentOption

    public init(userId: UUID, orderdProducts: [ProductPack], paymentOption: PaymentOption) {
        id = UUID()
        self.userId = userId
        timestamp = .now
        products = orderdProducts
        totalPrice = orderdProducts.reduce(0) { $0 + $1.product.price * Float64($1.quantity) }
        self.paymentOption = paymentOption
    }
}

extension Order: Codable  {
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case timestamp
        case products
        case totalPrice
        case paymentOption
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        userId = try container.decode(UUID.self, forKey: .userId)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        products = try container.decode([ProductPack].self, forKey: .products)
        totalPrice = try container.decode(Float64.self, forKey: .totalPrice)
        paymentOption = try container.decode(PaymentOption.self, forKey: .paymentOption)
    }

        


}

