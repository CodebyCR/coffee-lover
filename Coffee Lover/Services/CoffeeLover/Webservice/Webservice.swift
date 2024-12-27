//
//  Webservice.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public actor Webservice {
    private let dataBaseAPI: DatabaseAPI

    public init(apiSystem: consuming DatabaseAPI) {
        self.dataBaseAPI = apiSystem
    }

    @MainActor
    public func loadMenu() async throws -> Data {
        // TODO: implement as async sequence

        let menuJson = dataBaseAPI.baseURL.appendingPathComponent("menu")
        let (data, _) = try await URLSession.shared.data(from: menuJson)

        return data
    }

    public func getDrinkIds() async throws -> [String] {
        let indexIdsJson = dataBaseAPI.baseURL
            .appendingPathComponent("menu")
            .appendingPathComponent("ids")
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

    public func load(by id: String) async throws -> CoffeeModel {
        let menuJson = dataBaseAPI.baseURL
            .appendingPathComponent("menu")
            .appendingPathComponent("id")
            .appendingPathComponent(id)

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

    public func createNewOrder(by orderJSON: Data) async throws {
        let orderURL = dataBaseAPI.baseURL.appendingPathComponent("order")
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
}
