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

//    public struct ProductAsyncIterator: AsyncIteratorProtocol {
//        let drinkIds: [String]
//        let webservice: Webservice
//
//        fileprivate var currentIndex = 0
//
//        public init(drinkIds: [String], webservice: Webservice) {
//            self.drinkIds = drinkIds
//            self.webservice = webservice
//        }
//
//        public mutating func next() async throws -> (any Product)? {
//            guard currentIndex < drinkIds.count else {
//                return nil
//            }
//
//            let drinkId = drinkIds[currentIndex]
//            let product = try await webservice.load(by: consume drinkId)
//            currentIndex += 1
//
//            return product
//        }
//    }

//    public func makeIterator() async -> ProductAsyncIterator {
//        guard let drinkIds = try? await webservice.getDrinkIds() else {
//            print("No drink ids found")
//            return ProductAsyncIterator(drinkIds: [], webservice: webservice)
//        }
//
//        return ProductAsyncIterator(drinkIds: drinkIds, webservice: webservice)
//    }
}
