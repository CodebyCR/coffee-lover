//
//  ProductImageView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 22.05.25.
//
import SwiftUI
import Coffee_Kit

struct ProductImageView: View {
    @Binding var product: Product

    var body: some View {
            VStack {
                if let imageURL = product.imageUrl {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 200, minHeight: 200)
                            .cornerRadius(16)
                            .padding()

                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }
            }
        }
}
