//
//  OrderHistory.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.03.25.
//

import Coffee_Kit
import SwiftUI

struct OrderHistoryView: View {
    @Binding var orderHistory: [Order]

    var body: some View {
        ForEach(orderHistory, id: \.id) { order in
            VStack(alignment: .leading) {
                HStack {
                    // small font
                    Text("Order: \(order.id)")
                        .font(.caption)
                }

                HStack {
                    Text("Ordered at:")
                    Spacer()
                    Text(order.orderDate, style: .date)
                    Text(order.orderDate, style: .time)
                }
            }
        }
    }
}
