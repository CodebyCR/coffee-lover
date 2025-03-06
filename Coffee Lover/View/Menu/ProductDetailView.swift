//
//  ProductDetailView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 06.03.25.
//

import Coffee_Kit
import SwiftUI

struct ProductDetailView: View {
    @State public var product: any Product

    var body: some View {
        Text("ProductDetailView")
        Text(product.name)
        Text("\(product.id)")
    }
}

// #Preview {
//    let coffee = Coffee(
//    ProductDetailView(Coffee()
// }
