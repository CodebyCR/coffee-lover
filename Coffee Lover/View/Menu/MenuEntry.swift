//
//  MenuEntry.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import SwiftUI

struct MenuEntry: View {
    @State
    var product: Product

    var body: some View {
        HStack {
            HStack {
                ProductImageView(product: $product, frameSize: 54)
                    .padding(.trailing, 8)

                Text("\(product.categoryNumber)")
                    .fontWeight(.thin)
                    .italic()
                    .bold()

                Text(product.name)
                    .fontWeight(.semibold)
                    .italic()
            }

            Spacer()

            Text(CurrencyFormatter.formatAmount(product.price))
                .italic()

        }.frame(height: 60)
//            .padding(.leading, 8)
    }
}

#Preview {
    MenuEntry(product: Product())
        .preferredColorScheme(.dark)
}
