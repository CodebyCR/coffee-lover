//
//  OrderButtonView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//
import Coffee_Kit
import OSLog
import SwiftUI

@MainActor
struct OrderButtonView: View {
    let logger = Logger(subsystem: "codebyCR.coffee.lover", category: "OrderButtonView")

    @Environment(OrderBuilder.self) var orderBuilder
    @Environment(OrderManager.self) var orderManager
    @State private var activePopover: Bool = false
    @State private var orderResultMessage = ""

    var body: some View {
        Button {
            takeOrder()
        } label: {
            OrderButtonLabel()
        }
        .disabled(orderBuilder.products.isEmpty)
        .alert("Order Confirmed 🎉", isPresented: $activePopover) {
            Button("OK") {
                activePopover.toggle()
            }
        } message: {
            Text(orderResultMessage)
        }
    }

    fileprivate func takeOrder() {
        let result = orderManager.takeOrder(from: orderBuilder)

        switch result {
        case .success(let message):
            logger.info("Order successfully taken.")
            orderResultMessage = message
            activePopover.toggle()

        case .failure(let error):
            logger.error("Failed to take order: \(error.localizedDescription)")
            orderResultMessage = "Something went wrong, please try again."
            // Handle error appropriately, e.g., show an alert
        }

    }
}

#Preview("OrderButtonView (Darkmode)") {
    return OrderButtonView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderManager(from: WebserviceProvider(inMode: .dev)))
        .preferredColorScheme(.dark)
}

@MainActor
struct OrderButtonLabel: View {
    @Environment(OrderBuilder.self) var orderBuilder

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.green)
            .frame(height: 50)
            .opacity(0.8)
            .overlay(
                Text(String(format: "Order (%@)", CurrencyFormatter.formatAmount(orderBuilder.totalAmount)))
                    .foregroundColor(.white)
                    .font(.headline)
            )
            .padding([.bottom, .horizontal], 8)
    }
}
