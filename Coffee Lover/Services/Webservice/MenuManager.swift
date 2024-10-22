//
//  MenuManager.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

@Observable
public final class MenuManager {
    private var webservice: Webservice
    public var choseableProducts: [Product] = []

    init(webservice: Webservice) {
        self.webservice = webservice
    }

    @MainActor
    public func loadMenuEntries() async {
        do {
            let jsonData = try await webservice.loadMenu()
            let coffees = try JSONDecoder().decode([CoffeeModel].self, from: jsonData)
            choseableProducts.append(contentsOf: coffees)
        } catch {
            print(error)
        }
    }

//    @MainActor
//    public func loadMenuEntries2() async {
//        do {
//            for await menuEntry in try webservice.loadMenu() {}
//        } catch {
//            print(error)
//        }
//    }
}
