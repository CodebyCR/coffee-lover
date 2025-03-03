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
    @State private var selectedTab: MainTab = .menu

    var body: some View {
        TabView(selection: $selectedTab) {
            // MARK: - Orders

            Text("Unimplemented Orders")
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

            Text("Unimplemented cart")
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(MainTab.cart)
        }
        .accentColor(.brown)
    }
}

#Preview {
    ContentView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}

//                VStack {
//                    ZStack {
//                        ForEach(list, id: \.self) { listType in
//                            switch listType {
//                            case "Coffees":
//
//                            case "Cakes":
//                                CakeListView()
//
//                            default:
//                                EmptyView()
//                            }
//                        }
//
//                    }
//                    .gesture(
//                        DragGesture()
//                            .onEnded({ value in
//                                let threshold: CGFloat = 50
//                                if value.translation.width > threshold {
//                                    withAnimation {
//                                        currentIndex = max(0, currentIndex - 1)
//                                    }
//                                } else if value.translation.width < -threshold {
//                                    withAnimation {
//                                        currentIndex = min(list.count - 1, currentIndex + 1)
//                                    }
//                                }
//                            })
//                    )
//                }
//                .navigationBarTitle("Menu")
//                .toolbar {
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {
//                            Button {
//                                withAnimation {
//                                    currentIndex = max(0, currentIndex - 1)
//                                }
//                            } label: {
//                                Image(systemName: "arrow.left")
//                                    .font(.title)
//                            }
//                            Spacer()
//                            Button {
//                                withAnimation {
//                                    currentIndex = min(list.count - 1, currentIndex + 1)
//                                }
//                            } label: {
//                                Image(systemName: "arrow.right")
//                                    .font(.title)
//                            }
//                        }
//                        .padding(.horizontal, 50)
//                    }
//                }
