//
//  OrderManager.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//

import Foundation

@Observable
@MainActor
public final class OrderManager {
    @ObservationIgnored private var webservice: WebserviceProvider

    private(set) var pendingOrders: [Order] = []
    private(set) var completedOrders: [Order] = []
    private(set) var shoppingCard = ProductStore()

    public init(from webservice: WebserviceProvider) {
        self.webservice = webservice
    }

    public var orderService: OrderService {
        OrderService(databaseAPI: webservice.databaseAPI)
    }

    public func takeOrder(_ order: Order) {
        Task {
            do {
                try await orderService.takeOrder(order)
                pendingOrders.append(order)

            } catch {
                print("Error taking order: \(error)")
            }
        }
    }

//    func postRequestSequence(url: URL, requestData: Data) -> AsyncThrowingStream<ResponseData, Error> {
//        return AsyncThrowingStream { continuation in
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.httpBody = requestData
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                if let error = error {
//                    continuation.finish(throwing: error)
//                    return
//                }
//
//                guard let data = data else {
//                    continuation.finish(throwing: NSError(domain: "NoDataError", code: -1))
//                    return
//                }
//
//                do {
//                    let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: data)
//                    continuation.yield(decodedResponse)
//                    continuation.finish()
//                } catch {
//                    continuation.finish(throwing: error)
//                }
//            }
//
//            task.resume()
//        }
//    }
//
//    // Verwendung mit async/await:
//    func processPostRequest() async {
//        do {
//            let requestData = try JSONEncoder().encode(testData)
//            let url = URL(string: "127.0.0.1:8080/test/order/id=\(2)")!
//
//            for try await response in postRequestSequence(url: url, requestData: requestData) {
//                // Verarbeite die Antwort
//                print("Antwort: \(response)")
//            }
//        } catch {
//            print("Fehler: \(error)")
//        }
//    }
}
