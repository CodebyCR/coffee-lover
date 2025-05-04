//
//  CurrentOrderView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.03.25.
//

import Coffee_Kit
import SwiftUI

struct CurrentOrderView: View {
    @Binding var currentOrder: Order

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // small font
                Text("Order: \(currentOrder.id)")
                    .font(.caption)
            }

            HStack {
                Text("Ordered at:")
                Spacer()
                Text(currentOrder.orderDate, style: .date)
                Text(currentOrder.orderDate, style: .time)
            }

            //                    ForEach($currentOrder.products, id: \.id) { product in
            //                        HStack {
            ////                           Text(product.name)
            //                            Spacer()
            //                            Text(product.price.formatted(.currency(code: "USD")))
            //                        }
            //                    }
        }
    }
}

#Preview {
    CurrentOrderView(currentOrder: .constant(Order()))
}
