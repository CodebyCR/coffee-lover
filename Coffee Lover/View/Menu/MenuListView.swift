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
import OSLog

struct MenuListView: View {
    let log = Logger(subsystem: "com.codebycr.Coffee-Lover", category: "MenuListView")
    
    @Environment(MenuManager.self) var menu
    @Environment(OrderBuilder.self) var orderBuilder
    @State private var menuCategories = MenuCategory.allCases
    @State private var selectedCategory = MenuCategory.coffee
    @Binding var lookupValue: String

    init(lookupValue: Binding<String>) {
        print("Menu Created")
        self._lookupValue = lookupValue
    }

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(menuCategories, id: \.id) { category in
                    if !menu.items.isEmpty {
                        CategoryTitle(categoryTitle: category.rawValue)
                            .id(category)
                    }

                    ForEach(menu.getSelection(for: category, with: lookupValue)) { entry in
                        NavigationLink(value: NavigationTarget.productDetail(entry)) {
                            MenuEntry(product: entry)
                                .swipeActions {
                                    Button("Add") {
                                        print("Add \(entry.name) to cart ...")
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        orderBuilder.addProduct(entry)
                                    }
                                }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(selectedCategory.rawValue)
                        .frame(minWidth: 40, maxWidth: 200)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            .listStyle(.plain)
            .toolbarBackground(Color.brown.gradient)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .listRowSeparator(.hidden)
            .refreshable {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                print("Refreshing menu...")
                try? await Task.sleep(for: .seconds(2.0))
                print("Menu refreshed.")
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            .safeAreaInset(edge: .bottom) {
                if !menu.items.isEmpty {
                    CategorieChooserView(
                        menuCategories: $menuCategories,
                        selectedCategory: $selectedCategory
                    )
                }
            }
            .overlay {
                if menu.items.isEmpty {
                    ContentUnavailableView("No Internet connection.", systemImage: "wifi.exclamationmark.circle", description: Text("Please check your connection."))
                }
            }
            .task(priority: .userInitiated) {
                await addMenuEntiesAnimated()
            }
            .onChange(of: selectedCategory, initial: false) {
                print("Scrolling to \(selectedCategory.rawValue)...")
                withAnimation {
                    proxy.scrollTo(selectedCategory, anchor: .top)
                }
            }
        }
    }

    
    fileprivate func addMenuEntiesAnimated() async {
        guard menu.items.isEmpty else {
            return
        }

        for await product in await menu.productService.loadAll() { 
//            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                // animate menu entries...
                switch product {
                case .failure(let error):
                    log.warning("Failed to load product: \(error.localizedDescription)")
                case .success(let product):
                    log.info("Adding \(product.name)...")
                    menu.items.append(product)
                }
//            }
        }
    }
}

// #Preview("MenuListView") {
//    MenuListView()
//        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
//        .environment(OrderBuilder(for: UUID()))
//        .preferredColorScheme(.dark)
// }

// #Preview("ContentView") {
//    ContentView()
//        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
//        .environment(OrderBuilder(for: UUID()))
// }
