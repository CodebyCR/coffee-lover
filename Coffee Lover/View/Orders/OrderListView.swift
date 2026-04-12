//
//  OrderListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 03.03.25.
//

import Coffee_Kit
import SwiftUI

struct OrderListView: View {

    var body: some View {
        ZStack {
            VStack {
                CurrentOrderView()

                List {
                    CategoryTitle(categoryTitle: "Order History")
                        .scrollTargetLayout()

                        OrderHistoryView()

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
            try? await Task.sleep(for: .seconds(2))
            print("Orders refreshed")
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}

#Preview {
//    OrderListView()
    OrderNavigationView()
}
