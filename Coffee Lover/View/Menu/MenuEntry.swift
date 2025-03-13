//
//  MenuEntry.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import SwiftUI

struct MenuEntry: View {
    var productEntry: Product

    var body: some View {
        HStack {
            HStack {
                Text("\(productEntry.categoryNumber)")
                    .fontWeight(.thin)
                    .italic()
                    .bold()

                Text(productEntry.name)
                    .fontWeight(.semibold)
                    .italic()
            }

            Spacer()

            Text(CurrencyFormatter.formatAmount(productEntry.price))
                .italic()
        }.frame(
            height: 60
        )
        .padding(.leading, 8)
    }
}
