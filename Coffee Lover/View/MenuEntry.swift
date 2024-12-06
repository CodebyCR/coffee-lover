//
//  MenuEntry.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI

struct MenuEntry: View {
    var productEntry: any Product

    var body: some View {
        HStack {
            HStack {
                Text("\(productEntry.id)")
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
