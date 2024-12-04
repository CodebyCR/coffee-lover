//
//  MenuManager.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

@Observable
public final class MenuManager {
    @ObservationIgnored private var webservice: Webservice
    public var choseableProducts: [Product] = []

    init(webservice: Webservice) {
        self.webservice = webservice
    }

    @MainActor
    public func loadMenuEntries() async {
        do {
//            let jsonData = try await webservice.loadMenu()
//            print(jsonData)
//            let coffees = try JSONDecoder().decode([CoffeeModel].self, from: jsonData)
//            choseableProducts.append(contentsOf: coffees)

            for try await item in await webservice.load(by: "1", "2", "3") {
                choseableProducts.append(item)
            }
        } catch {
            print(error)
        }
    }
}
