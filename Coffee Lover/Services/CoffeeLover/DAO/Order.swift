//
//  Order.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct Order: Identifiable, Sendable, Codable {
    public let id: UUID
    public let userId: UUID
    public let timestamp: Date
    public let products: ProductStore
    public let totalPrice: Float64
    public let paymentOption: PaymentOption

    public init(userId: UUID, orderdProducts: ProductStore, paymentOption: PaymentOption) {
        id = UUID()
        self.userId = userId
        timestamp = .now
        products = orderdProducts
        totalPrice = orderdProducts.total()
        self.paymentOption = paymentOption
    }

}
