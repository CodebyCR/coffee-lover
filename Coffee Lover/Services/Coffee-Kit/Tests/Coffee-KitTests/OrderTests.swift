//
//  OrderTests.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 30.12.24.
//

import Foundation
import Testing
@testable import Coffee_Kit

struct OrderTests {

    @Test func testTakingOrder() async {
        let databaseAPI = DatabaseAPI.dev
        let webservice = Webservice(apiSystem: databaseAPI)
        let orderManager = OrderManager(webservice: webservice)

        var products = orderManager.shoppingCard
        products.add( CakeModel(), to: "Cakes")
        products.add( CoffeeModel(), to: "Coffees")
        products.add( CakeModel(), to: "Cakes")

        let json = try! JSONEncoder().encode(products)
        print(json)

        await orderManager.takeOrder()



    }

}


