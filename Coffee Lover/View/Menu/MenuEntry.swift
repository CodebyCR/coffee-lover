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
    var productEntry: Product

    var body: some View {
        HStack {

            HStack {

                ProductImageMinView(product: $productEntry)

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

            }.frame(height: 60)
//            .padding(.leading, 8)
        }

}


#Preview {
    MenuEntry(productEntry: Product())
    .preferredColorScheme(.dark)
}

struct ProductImageMinView: View {
    @Binding var product: Product
    let framesize: CGFloat = 54

    var body: some View {
        VStack {
            if let imageURL = product.imageUrl {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: framesize, height: framesize)
                        .cornerRadius(8)
                        .padding()
                    
                } placeholder: {
                    ProgressView()
                        .frame(width: framesize, height: framesize)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: framesize, height: framesize)
                    .padding()
            }
        }
    }
}
