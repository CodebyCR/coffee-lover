//
//  Order.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct Order: Identifiable, Sendable, Codable {
    public let id: UUID
    public let timestamp: Date
    public let products: [CoffeeModel]
    public let totalPrice: Float64
    public let paymentOption: PaymentOption

    public init(orderdProducts: [CoffeeModel], paymentOption: PaymentOption) {
        id = UUID()
        timestamp = .now
        products = orderdProducts
        totalPrice = orderdProducts.map { $0.price }.reduce(0, +)
        self.paymentOption = paymentOption
    }
}
