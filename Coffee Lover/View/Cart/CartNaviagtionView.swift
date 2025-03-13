//
//  OrderNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//

import Coffee_Kit
import SwiftUI

struct CartNaviagtionView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ShoppingCartView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Cart")
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .fontWeight(.bold)
                            }
                        }
                    }
            }
        }
        .background(
            Color
                .brown
                .gradient
        )
    }
}

#Preview {
    CartNaviagtionView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
