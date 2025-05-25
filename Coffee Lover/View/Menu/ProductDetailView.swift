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
    @State public var product: Product

    var body: some View {
        // Image Placeholder
        ScrollView {

            ProductImageView(product: $product)

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


            DescriptionSectionView(
                title: "Description",
                 description: "Handcrafted coffee with a touch of cream. Made with love and care."
            ).padding(.horizontal, 8)

            DescriptionSectionView(
                title: "Ingredients",
                description: "water, coffee, milk, sugar, cream."
            ).padding(.horizontal, 8)

            Spacer()

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
                        .padding([.bottom, .horizontal], 8)
                }
                //            .padding([.bottom, .horizontal], 8)
            }
        }
    }
}

//#Preview {
//    let coffee = Product()
//    ProductDetailView(product: coffee)
//        .environment(OrderBuilder(for: UUID()))
//}



struct DescriptionSectionView: View {

    public let title: String
    public let description: String

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.brown)
                .opacity(0.2)
            
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.vertical, 8)
                
                
                Text(description)
                    .padding(.bottom, 8)

            }.padding(.horizontal, 12)
        }
    }
}


#Preview {
    DescriptionSectionView(
        title: "Description",
         description: "Handcrafted coffee with a touch of chocolate. Made with love and care."
    )
    .padding()
}
