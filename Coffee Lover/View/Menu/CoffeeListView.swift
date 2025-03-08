//
//  CoffeeListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//

//
//  CoffeeListContent.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//
import Coffee_Kit
import SwiftUI

@MainActor
struct CoffeeListView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                CoffeeListSubView()
                    .safeAreaInset(edge: .bottom) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 50)
                            .foregroundColor(.brown)

                            .background(.ultraThinMaterial)
                            .opacity(0.8)
                            .overlay {
                                Text("Categorie Placeholder")
                                    .foregroundStyle(.white)

                                    .fontWeight(.bold)
                            }
                            .padding([.bottom, .horizontal], 8)
                    }
            }
        }
        .background(
            Color
                .brown
                .gradient
        )

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Coffee")
                        .foregroundStyle(.white)
                        .padding(4)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    CoffeeListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
