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

//    @MainActor
//    public func loadMenuEntries2() async -> AsyncThrowingStream<Data, Error> {
//        return AsyncThrowingStream { continuation in
//            do {
//                try self.download(url, progressHandler: { progress in
//                    continuation.yield(.downloading(progress))
//                }, completion: { result in
//                    switch result {
//                    case .success(let data):
//                        continuation.yield(.finished(data))
//                        continuation.finish()
//                    case .failure(let error):
//                        continuation.finish(throwing: error)
//                    }
//                })
//            } catch {
//                continuation.finish(throwing: error)
//            }
//        }
//    }
}
