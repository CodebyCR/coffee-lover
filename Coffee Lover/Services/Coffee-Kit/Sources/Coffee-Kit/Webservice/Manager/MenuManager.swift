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
    public var choseableProducts: [any Product] = []

    public init(){
        self.webservice = Webservice(inMode: .dev)
    }

    public init(from webservice: Webservice) {
        self.webservice = webservice
    }

    @MainActor
    public func loadMenuEntries() async {
        do {
            let drinkIds = try await webservice.getDrinkIds()

            for try await item in await webservice.load(by: drinkIds) {
                choseableProducts.append(item)
            }
        } catch {
            print(error)
        }
    }

    @MainActor
    public func loadCakes() async -> AsyncThrowingStream<CoffeeModel, any Error>{
        guard let cakeIds = try? await webservice.getCakeIds() else {
            print("Error to fetch drink ids")
            return AsyncThrowingStream { continuation in
                continuation.finish(throwing: FetchError.decodingError)
            }
        }

        return await webservice.load(by: cakeIds)
    }

}
