//
//  Order.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct Order: Sendable {
    public let id: UUID
    public let timestamp: Date
    public let orderdProducts: [Product]
    public let totalPrice: Float64
    public let paymentOption: PaymentOption


    public init(id: UUID = UUID(), timestamp: Date = .now, orderdProducts: [Product], totalPrice: Float64, paymentOption: PaymentOption) {
        self.id = id
        self.timestamp = timestamp
        self.orderdProducts = orderdProducts
        self.totalPrice = totalPrice
        self.paymentOption = paymentOption
    }
}
