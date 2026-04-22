//
//  OrderHistory.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.03.25.
//

import Coffee_Kit
import SwiftUI
import OSLog

struct OrderHistoryView: View {
    private let log = Logger(subsystem: "com.codebycr.Coffee-Lover", category: "OrderHistoryView")
    @Environment(OrderManager.self) private var orderManager
    
    init(){
        log.info("OrderHistoryView.init")
    }

    var body: some View {
        VStack {
            ForEach(orderManager.orderHistory) { order in
                OrderHistoryItem(order: order)
                    .onAppear{
                        guard order.orderDate == orderManager.orderHistory.last?.orderDate else {
                            return
                        }
                        
                        Task(name: "Fetch more orders") {
                            await orderManager.loadOrderHistory(before: order.orderDate)
                        }
                    }
            }
        }
        .task(name: "Initial load order history") {
            log.info("Initial load order history")
            await orderManager.loadOrderHistory()
        }
  
    }
        
}

struct OrderHistoryItem: View {
    public let order: Order
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Text("Order: \(order.id)")
                    .font(.caption)
            }

            HStack {
                Text("Ordered at:")
                Spacer()
                Text(order.orderDate, style: .date)
                Text(order.orderDate, style: .time)
            }
        }
    }
}
