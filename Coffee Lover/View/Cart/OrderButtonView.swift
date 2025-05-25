//
//  OrderButtonView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//
import Coffee_Kit
import OSLog
import SwiftUI

struct OrderButtonView: View {
    let logger = Logger(subsystem: "codebyCR.coffee.lover", category: "OrderButtonView")

    @Environment(OrderBuilder.self) var orderBuilder
    @Environment(OrderManager.self) var orderManager
    @State private var activePopover: Bool = false



    var body: some View {
        Button {
            logger.info("Ordering...")

            do{
                let newOrder = try orderBuilder.build()
                orderManager.takeOrder(newOrder)
                activePopover.toggle()
            } catch {
                logger.error("Order could not be created. \(error.localizedDescription)")
                // GUI feedback
            }

        } label: {
            OrderButtonLabel(orderBuilder: orderBuilder)
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

#Preview("OrderButtonView (Darkmode)") {
    let webservice = WebserviceProvider(inMode: .dev)

    return OrderButtonView()
        .environment(MenuManager(from: webservice))
        .environment(OrderManager(from: webservice))
        .preferredColorScheme(.dark)
}

struct OrderButtonLabel: View {
    @Bindable public var orderBuilder: OrderBuilder

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
