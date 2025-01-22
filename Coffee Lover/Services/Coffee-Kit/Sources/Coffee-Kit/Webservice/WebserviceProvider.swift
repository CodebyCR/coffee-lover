//
//  Webservice.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public actor Webservice {
    private let databaseAPI: DatabaseAPI

    public init(inMode databaseAPI: consuming DatabaseAPI) {
        self.databaseAPI = databaseAPI
    }

    @MainActor
    public func loadMenu() async throws -> Data {
        // TODO: implement as async sequence

        let menuJson = databaseAPI.baseURL / "menu"
        let (data, _) = try await URLSession.shared.data(from: menuJson)

        return data
    }

    public func getDrinkIds() async throws -> [String] {
        let indexIdsJson = databaseAPI.baseURL / "menu" / "ids"
        let (data, response) = try await URLSession.shared.data(from: indexIdsJson)

        guard let drinkIds = try? JSONDecoder().decode([String].self, from: data) else {
            print(response)
            print("""
            Error in \(#file)
            \t\(#function) \(#line):\(#column)
            \tStatus code: \((response as? HTTPURLResponse)?.statusCode ?? 0)
            """)
            throw FetchError.decodingError
        }

        return drinkIds
    }

    public func load(by id: consuming String) async throws -> CoffeeModel {
        let menuJson = databaseAPI.baseURL / "menu" / "id" / id

        let (data, response) = try await URLSession.shared.data(from: menuJson)

        guard let coffee = try? JSONDecoder().decode(CoffeeModel.self, from: data) else {
            print(response)

            let stacktrace = Thread.callStackSymbols.joined(separator: "\n")
            print(stacktrace)
            print("""
            Error in \(#file)
            \t\(#function) \(#line):\(#column)
            \tStatus code: \((response as? HTTPURLResponse)?.statusCode ?? 0)
            """)
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

    public func create(new order: Order) async throws {
        let orderJSON = try JSONEncoder().encode(order)
        let orderURL = databaseAPI.baseURL / "order" / "\(order.id)"
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.httpBody = orderJSON

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201
        else {
            print("""
            Error in \(#file)
            \t\(#function) \(#line):\(#column)
            \tStatus code: \((response as? HTTPURLResponse)?.statusCode ?? 0)
            """)
            throw FetchError.invalidResponse
        }
    }


    public func getCakeIds() async throws -> [String] {
        let indexIdsJson = databaseAPI.baseURL / "cake" / "ids"
        let (data, response) = try await URLSession.shared.data(from: indexIdsJson)

        guard let cakeIds = try? JSONDecoder().decode([String].self, from: data) else {
            print(response)
            print("""
            Error in \(#file)
            \t\(#function) \(#line):\(#column)
            \tStatus code: \((response as? HTTPURLResponse)?.statusCode ?? 0)
            """)
            throw FetchError.decodingError
        }

        return cakeIds
    }

}
