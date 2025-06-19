//
//  ProductQuantityView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 06.03.25.
//

import Coffee_Kit
import SwiftUI

@MainActor
struct ProductQuantityView: View {
    @Environment(MenuManager.self) var menuManager
    @Environment(OrderBuilder.self) var orderBuilder
    @StateObject var orderProduct: OrderProduct

    var body: some View {
        HStack {
//            Stepper(value: $orderProduct.quantity, in: 1 ... 100) {
//                Text()
//            }
//            .onSubmit {
//                orderBuilder.updateQuantity(of: orderProduct)
//            }

            Stepper("\(orderProduct.quantity) x \(orderProduct.product.name)") {
                orderProduct.quantity += 1
                orderBuilder.updateQuantity(of: orderProduct)
            } onDecrement: {
                orderProduct.quantity -= 1
                orderBuilder.updateQuantity(of: orderProduct)
            }
            .fontWeight(.semibold)
            .italic()

            Spacer()

            Text(CurrencyFormatter.formatAmount(orderProduct.price))
                .italic()

        }.frame(
            height: 60
        )
        .padding(.leading, 8)
    }
}

#Preview {
    ProductQuantityView(orderProduct: OrderProduct())
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
