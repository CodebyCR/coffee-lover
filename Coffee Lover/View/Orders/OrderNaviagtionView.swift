//
//  OrderNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//

import Coffee_Kit
import SwiftUI

struct OrderNaviagtionView: View {
    var body: some View {
        NavigationStack {
            VStack {
                OrderListView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Orders")
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
    OrderNaviagtionView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
