//
//  ContentView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import SwiftUI

enum MainTab {
    case orders, menu, cart
}

@MainActor
struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder
    @State private var selectedTab: MainTab = .menu

    var body: some View {
        // MARK: - TabView
        TabView(selection: $selectedTab) {
            // MARK: - Orders

            OrderNaviagtionView()
                .tabItem {
                    Label("Orders", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(MainTab.orders)
                .badge(1)

            // MARK: - Menu

            MenuNaviagtionView()
                .tabItem {
                    Label("Menu", systemImage: "list.bullet")
                }
                .tag(MainTab.menu)

            // MARK: - Cart


            CartNaviagtionView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(MainTab.cart)
                .badge(orderBuilder.totalProducts)

        }
        .accentColor(.brown)

    }
}

#Preview {
    ContentView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID()))
}
