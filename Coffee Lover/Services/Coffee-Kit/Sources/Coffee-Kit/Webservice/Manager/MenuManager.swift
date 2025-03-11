//
//  MenuManager.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

@Observable
@MainActor
public final class MenuManager {
    // MARK: - Properties

    @ObservationIgnored private var webservice: WebserviceProvider
    public var coffees: [CoffeeModel] = []
    public var cakes: [CakeModel] = []

    // MARK: - Computed Properties

    public var coffeeSequence: CoffeeService {
        // print errors and filter out nil values

        return CoffeeService(databaseAPI: webservice.databaseAPI)
    }

    public var cakeService: CakeService {
        return CakeService(databaseAPI: webservice.databaseAPI)
    }

    // MARK: - Initializer

    public init() {
        self.webservice = WebserviceProvider(inMode: .dev)
    }

    public init(from webservice: WebserviceProvider) {
        self.webservice = webservice
    }
}
