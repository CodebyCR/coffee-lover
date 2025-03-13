//
//  ProductQuantityView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 06.03.25.
//

import Coffee_Kit
import SwiftUI

struct ProductQuantityView: View {
    @Environment(MenuManager.self) var menuManager
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @Binding var productEntry: Product
    @Binding var quantity: UInt8

    init(of productWithQuantity: OrderProduct) {
        self._productEntry = Binding.constant(productWithQuantity.product)

        self._quantity = Binding.constant(productWithQuantity.quantity)
    }

    var body: some View {
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

        HStack {
            Stepper(value: $quantity, in: 0 ... 100) {
                HStack {
                    Text("\(quantity) x \(productEntry.name)")
                        .fontWeight(.semibold)
                        .italic()

                    Spacer()

                    Text(CurrencyFormatter.formatAmount(productEntry.price))
                        .italic()
                }
            }

        }.frame(
            height: 60
        )
        .padding(.leading, 8)
    }
}

// #Preview {
//    ProductQuantityView()
// }
