//
//  ContentView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import SwiftUI

enum MainTab {
    case orders, menu, cart, search
}

@MainActor
struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @Environment(NavigationManager.self) var navigationManager: NavigationManager
    @State private var selectedTab: MainTab = .menu
    @State private var lookupValue: String = ""
    

    var body: some View {
        
        // MARK: - TabView

        TabView(selection: $selectedTab) {
            
            // MARK: - Orders
            
            Tab("Orders", systemImage: "tray.and.arrow.down.fill", value: MainTab.orders) {
                OrderNavigationView()
            }
            .badge(1)

            // MARK: - Menu

            Tab("Menu", systemImage: "list.bullet", value: MainTab.menu) {
                MenuNavigationView()
            
            }

            // MARK: - Cart
            
            Tab("Cart", systemImage: "cart", value: MainTab.cart) {
                CartNavigationView()
            }
            .badge(orderBuilder.totalProducts)
            
            // MARK: - Search
            
            Tab("Search", systemImage: "magnifyingglass", value: MainTab.search, role: .search) {
                @Bindable var navManager = navigationManager
                NavigationStack(path: $navManager.searchPath) {
                    if lookupValue.isEmpty {
                        
                        SearchCategoryGrid(lookupValue: $lookupValue)
                            .toolbarBackground(Color.brown.gradient)
                            .toolbarBackground(.visible, for: .navigationBar)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    VStack {
                                        Text("Categories")
                                            .foregroundStyle(.white)
                                            .padding(4)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            
                        
                    }
                    else {
                        MenuNavigationView(filteredOn: $lookupValue)
                    }
                }
                .navigationDestination(for: NavigationTarget.self) { target in
                    navigationManager.destinationView(for: target)
                        .environment(navigationManager)
                }
                .searchable(text: $lookupValue, placement: .navigationBarDrawer, prompt: "Foodname, Ingriedients, etc. ")
                .background(
                    Color
                        .brown
                        .gradient
                )

            }
            
        }
        .accentColor(.brown)
        .onChange(of: selectedTab) {
            hideKeyboard()
        }
        // .tabBarMinimizeBehavior(.onScrollDown) (ios26)
    }
}

#Preview {
    ContentView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
