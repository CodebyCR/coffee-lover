//
//  OrderListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 03.03.25.
//

import Coffee_Kit
import SwiftUI

struct OrderListView: View {

    @State private var currentOrder = Order()
    @State private var isExpanded = false
    @State private var orderHistory = (0 ... 15).map { _ in
        Order()
    }

    var body: some View {
        ZStack {
            VStack {
                CurrentOrderView(currentOrder: $currentOrder, isExpanded: $isExpanded)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            isExpanded.toggle()
                        }
                    }

                List {

                    CategoryTitle(categoryTitle: "Order History")
                        .scrollTargetLayout()

                        OrderHistoryView(orderHistory: $orderHistory)

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
            // Simulate a network call to fetch new orders
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
            print("Orders refreshed")
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}

#Preview {
//    OrderListView()
    OrderNaviagtionView()
}
