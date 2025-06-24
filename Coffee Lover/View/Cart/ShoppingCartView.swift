//
//  ShoppingCart.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 03.03.25.
//

import Coffee_Kit
import SwiftUI

@MainActor
struct ShoppingCartView: View {
    @Environment(OrderBuilder.self) var orderBuilder
    @Environment(MenuManager.self) var menuManager

    var body: some View {
        NavigationStack {
            List {
                ForEach(orderBuilder.products, id: \.id) { productWithQuantity in
                    NavigationLink(value: productWithQuantity) {
                        ProductQuantityView(orderProduct: productWithQuantity)
                            .swipeActions {
                                Button("Remove") {
                                    print("Remove \(productWithQuantity.product.name) from cart ...")
                                    orderBuilder.removeAll(productWithQuantity.product)
                                }
                            }
                    }

                }
            }
            .listStyle(.plain)
            .toolbarBackground(Color.brown.gradient)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Cart")
                            .foregroundStyle(.white)
                            .padding(4)
                            .fontWeight(.bold)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
//                if !orderBuilder.products.isEmpty { // TODO: killed popover
                    OrderButtonView()
//                }
            }
            .overlay {
                if orderBuilder.products.isEmpty {
                    ContentUnavailableView("Your cart is empty.", systemImage: "cart", description: Text("Enjoy some tasty pieces ❤️"))
                }
            }
            .navigationDestination(for: OrderProduct.self) { productWithQuantity in
                ProductDetailView(product: productWithQuantity.product)
            }


        }
    }
}

// #Preview {
//    ShoppingCartView()
//        .environment(OrderBuilder(for: UUID()))
// }
