
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
        ForEach(orderManager.orderHistory) { order in
            OrderHistoryItem(order: order)
                .onAppear {
                    if order.id == orderManager.orderHistory.last?.id {
                        log.info("Reached end of list, fetching more orders before \(order.orderDate)")
                        Task {
                            await orderManager.loadOrderHistory(before: order.orderDate)
                        }
                    }
                }
        }
        
        if orderManager.isFetchingHistory {
            HStack {
                Spacer()
                ProgressView("Loading orders...")
                    .padding()
                Spacer()
            }
            .listRowSeparator(.hidden)
        } else if orderManager.orderHistory.isEmpty && orderManager.hasReachedEnd {
            Text("No orders found.")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
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
