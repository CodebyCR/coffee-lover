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
    private(set) var shoppingCard = ProductStore()

    init(webservice: Webservice) {
        self.webservice = webservice
    }

    public func takeOrder() async {
        let paymentOption = PaymentOption.applePay
        let userId = UUID()
        let order = Order(userId: userId, orderdProducts: shoppingCard, paymentOption: paymentOption)

        do {
            try await webservice.create(new: order)
        } catch {
            print(error)
        }
    }
}
