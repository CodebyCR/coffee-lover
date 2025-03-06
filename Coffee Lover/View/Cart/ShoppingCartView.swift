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
    @State private var activePopover: Bool = false

    var body: some View {
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
                            // Stepper need Binding (outsource to separate view)
                            // Quantity with stepper
                            //                        HStack {
                            //                            Text("\(productWithQuantity.quantity)")
                            //
                            //                            @Bindable var quantity: Int = productWithQuantity.quantity
                            //
                            //                            Stepper(value: $quantity, in: 0 ... 100) {
                            //                                Text(productWithQuantity.product.name)
                            //                            }
                            //                        }
                            MenuEntry(productEntry: productWithQuantity.product)
                                .swipeActions {
                                    Button("Add") {
                                        print("Add \(productWithQuantity.product.name) to cart ...")
                                    }
                                }
                        }
                    )
                }
            }

            //        Spacer()
            // Order Button
            Button {
                print("Ordering...")
                let _ = orderBuilder.build() // do something with the order
                activePopover.toggle()

            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green)
                    .frame(height: 50)
                    .overlay(
                        Text(String(format: "Order (%@)", CurrencyFormatter.formatAmount(orderBuilder.totalAmount)))
                            .foregroundColor(.white)
                            .font(.headline)
                    )
            }
            .disabled(orderBuilder.products.isEmpty)
            .padding([.bottom, .horizontal], 16)
            .alert("Order Confirmed 🎉", isPresented: $activePopover) {
                Button("OK") {
                    activePopover.toggle()
                }
            } message: {
                Text("Your order arrive you sone.")
            }
        }
    }
}

#Preview {
    ShoppingCartView()
        .environment(OrderBuilder(for: UUID()))
}
