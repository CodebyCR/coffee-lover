//
//  OrderManager.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//

import Foundation

@Observable
public final class OrderManager {
    @ObservationIgnored private var webservice: Webservice

    private(set) var pendingOrders: [Order] = []
    private(set) var completedOrders: [Order] = []
    private(set) var shoppingCard = ShoppingCard()

    init(webservice: Webservice) {
        self.webservice = webservice
    }

    public func takeOrder() {
        let shoppingItems = shoppingCard.items
        let totalPrice = shoppingItems.map { $0.price }.reduce(0, +)
        let paymentOption = PaymentOption.applePay

        let newOrder = Order(orderdProducts: shoppingItems, totalPrice: totalPrice, paymentOption: paymentOption)
        // POST request with newOrder json

    }
}
