//
//  Webservice.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public actor Webservice {
    private let apiSystem: APISystem

    public init(apiSystem: consuming APISystem) {
        self.apiSystem = apiSystem
    }

    @MainActor
    public func loadMenu() async throws -> Data {
        // TODO: implement as async sequence

        let menuJson = apiSystem.baseURL.appendingPathComponent("menu")
        let (data, _) = try await URLSession.shared.data(from: menuJson)

        return data
    }

    public func load(by id: String) async throws -> CoffeeModel {
        let menuJson = apiSystem.baseURL
            .appendingPathComponent("menu")
            .appendingPathComponent("id={\(id)}")
        let (data, _) = try await URLSession.shared.data(from: menuJson)

        guard let coffee = try? JSONDecoder().decode(CoffeeModel.self, from: data) else {
            throw FetchError.decodingError
        }

        return coffee
    }

    public func load(by ids: String...) async -> AsyncThrowingStream<CoffeeModel, Error> {
        return AsyncThrowingStream<CoffeeModel, Error> { continuation in
            Task {
                do {
                    for id in ids {
                        let coffeeModel = try await load(by: id)
                        continuation.yield(coffeeModel)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
