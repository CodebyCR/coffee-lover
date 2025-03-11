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
    @State private var menuCategories: [MenuCategory] = MenuCategory.allCases
    @State private var selectedCategory: MenuCategory = .coffee

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                CoffeeListSubView()
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

struct CategorieChooserView: View {
    @Binding var menuCategories: [MenuCategory]
    @Binding var selectedCategory: MenuCategory

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(height: 48)
            .foregroundColor(.brown)
            .background(.ultraThinMaterial)
            .opacity(0.8)
            .overlay {
                SegmentedPicker(
                    selection: $selectedCategory,
                    items: $menuCategories,
                    selectionColor: .brown
                ) { category in
                    Text(category.rawValue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .background(selectedCategory == category ? .brown : .clear)
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            }
            .padding([.bottom, .horizontal], 8)
    }
}
