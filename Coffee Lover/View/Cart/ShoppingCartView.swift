//
//  ShoppingCart.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 03.03.25.
//

import Coffee_Kit
import SwiftUI

struct ShoppingCartView: View {
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if orderBuilder.products.isEmpty {
                        ContentUnavailableView("Your cart is Empty.", systemImage: "cart", description: Text("Enjoy some tasty pices ❤️"))
                    }

                    ForEach(orderBuilder.products, id: \.id) { productWithQuantity in
                        NavigationLink(
                            destination: {
                                ProductDetailView(product: productWithQuantity.product)
                            }, label: {
                                ProductQuantityView(of: productWithQuantity)
                                    .swipeActions {
                                        Button("Remove") {
                                            print("Remove \(productWithQuantity.product.name) from cart ...")
                                            orderBuilder.removeAll(productWithQuantity.product)
                                        }
                                    }
                            }
                        )
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    OrderButtonView()
                }
            }
        }
    }
}

#Preview {
    ShoppingCartView()
        .environment(OrderBuilder(for: UUID()))
}

struct OrderButtonView: View {
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @State private var activePopover: Bool = false

    var body: some View {
        Button {
            print("Ordering...")
            let _ = orderBuilder.build() // do something with the order
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
        }
        .disabled(orderBuilder.products.isEmpty)
        .padding([.bottom, .horizontal], 8)
        .alert("Order Confirmed 🎉", isPresented: $activePopover) {
            Button("OK") {
                activePopover.toggle()
            }
        } message: {
            Text("Your order will arrive soon.")
        }
    }
}
