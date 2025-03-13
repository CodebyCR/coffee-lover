//
//  ShoppingCart.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 03.03.25.
//

import Coffee_Kit
import SwiftUI

struct ShoppingCartView: View {
    @Environment(OrderBuilder.self) var orderBuilder
    @Environment(MenuManager.self) var menuManager

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

