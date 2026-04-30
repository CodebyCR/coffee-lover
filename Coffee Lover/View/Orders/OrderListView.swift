
import Coffee_Kit
import SwiftUI

struct OrderListView: View {
    @Environment(OrderManager.self) private var orderManager
    @State private var orderExists: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CurrentOrderView()
                    .padding(.vertical)

                List {
                    Section {
                        CategoryTitle(categoryTitle: "Order History")
                            .scrollTargetLayout()
                        
                        OrderHistoryView()
                    }
                }
                .scrollTargetBehavior(.viewAligned)
                .listStyle(.insetGrouped)
            }
        }
        .background(
            Color
                .brown
                .gradient
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Order")
                        .foregroundStyle(.white)
                        .padding(4)
                        .fontWeight(.bold)
                }
            }
        }
        .refreshable {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            await orderManager.loadOrderHistory()
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
        .task {
            orderExists = orderManager.containsOrder
            if orderManager.orderHistory.isEmpty {
                print("OrderListView task: Initial history load")
                await orderManager.loadOrderHistory()
            }
        }
    }
}

#Preview {
    OrderNavigationView()
}
