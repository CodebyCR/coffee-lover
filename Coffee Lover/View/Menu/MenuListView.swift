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
struct MenuListView: View {
    @State private var menuCategories: [MenuCategory] = MenuCategory.allCases
    @State private var selectedCategory: MenuCategory = .coffee

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                MenuListSubView(selectedCategory: $selectedCategory)
                    .safeAreaInset(edge: .bottom) {
                        CategorieChooserView(menuCategories: $menuCategories, selectedCategory: $selectedCategory)
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
                    Text(selectedCategory.rawValue)
                        .foregroundStyle(.white)
                        .padding(4)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    MenuListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
        .preferredColorScheme(.dark)
}


