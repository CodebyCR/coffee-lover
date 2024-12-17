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

    public func getDrinkIds() async throws -> [String] {
        let indexIdsJson = apiSystem.baseURL
            .appendingPathComponent("menu")
            .appendingPathComponent("index_ids")
        let (data, _) = try await URLSession.shared.data(from: indexIdsJson)

        guard let drinkIds = try? JSONDecoder().decode([String].self, from: data) else {
            throw FetchError.decodingError
        }

        return drinkIds
    }

    public func load(by id: String) async throws -> CoffeeModel {
        let menuJson = apiSystem.baseURL
            .appendingPathComponent("menu")
            .appendingPathComponent("id")
            .appendingPathComponent("\(id)")

        let (data, _) = try await URLSession.shared.data(from: menuJson)

        guard let coffee = try? JSONDecoder().decode(CoffeeModel.self, from: data) else {
            throw FetchError.decodingError
        }

        return coffee
    }

    public func load(by ids: [String]) async -> AsyncThrowingStream<CoffeeModel, Error> {
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

    public func createNewOrder(by orderJSON: Data) async throws {
        let orderURL = apiSystem.baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.httpBody = orderJSON

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201
        else {
            throw FetchError.invalidResponse
        }
    }
}
