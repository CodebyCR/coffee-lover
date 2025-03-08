//
//  ProductDetailView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 06.03.25.
//

import Coffee_Kit
import SwiftUI

struct ProductDetailView: View {
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @State public var product: any Product

    var body: some View {
        // Image Placeholder
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()

            HStack {
                Text(product.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .italic()

                Spacer()

                Text(CurrencyFormatter.formatAmount(product.price))
                    .font(.title)
                    .italic()
            }.padding(.horizontal, 24)

            // description & ingredients
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 16)

                Text("Handcrafted coffee with a touch of chocolate. Made with love and care.")
                    .padding(.top, 8)

                Text("Ingredients")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 16)

                Text("milk, sugar, coffee, water, chocolate, cream")
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                print("Add to cart")
                orderBuilder.addProduct(product)
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green)
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    .opacity(0.8)
                    .overlay(
                        Text(String(format: "Add to cart (%@)", CurrencyFormatter.formatAmount(product.price)))
                            .foregroundColor(.white)
                            .font(.headline)
                    )
            }
            .padding([.bottom, .horizontal], 8)
        }
    }
}

#Preview {
    let coffee = CoffeeModel()
    ProductDetailView(product: coffee)
        .environment(OrderBuilder(for: UUID()))
}
