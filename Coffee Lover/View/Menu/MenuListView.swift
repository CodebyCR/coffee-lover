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
                Spacer(minLength: 8)
                MenuListSubView(selectedCategory: $selectedCategory)
                    .safeAreaInset(edge: .bottom) {
                        CategorieChooserView(menuCategories: $menuCategories, selectedCategory: $selectedCategory)
                    }
            }
        }
        .background(Color.brown.gradient)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(selectedCategory.rawValue)
                    .frame(minWidth: 40, maxWidth: 200)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview("MenuListView") {
    MenuListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
        .preferredColorScheme(.dark)
}

#Preview("ContentView") {
    ContentView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
