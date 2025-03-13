//
//  OrderButtonView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//
import Coffee_Kit
import SwiftUI

struct OrderButtonView: View {
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @Environment(OrderManager.self) var orderManager: OrderManager
    @State private var activePopover: Bool = false

    var body: some View {
        Button {
            print("Ordering...")
            guard let newOrder = orderBuilder.build() else {
                print("Order could not be created")
                return
            }

            orderManager.takeOrder(newOrder)
            activePopover.toggle()

        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.green)
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .opacity(0.8)
                .overlay(
                    Text(String(format: "Order (%@)", CurrencyFormatter.formatAmount(orderBuilder.totalAmount)))
                        .foregroundColor(.white)
                        .font(.headline)
                )
                .padding([.bottom, .horizontal], 8)
        }
        .disabled(orderBuilder.products.isEmpty)
//        .padding([.bottom, .horizontal], 8)
        .alert("Order Confirmed 🎉", isPresented: $activePopover) {
            Button("OK") {
                activePopover.toggle()
            }
        } message: {
            Text("Your order will arrive soon.")
        }
    }
}
