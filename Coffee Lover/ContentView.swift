//
//  ContentView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @Environment(MenuManager.self) private var menu

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    List {
                        ForEach(menu.choseableProducts, id: \.id) { entry in
                            MenuEntry(productEntry: entry)
                                .swipeActions {
                                    Button("Order") {
                                        print("Order \(entry.name)...")
                                    }
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
            .task {
                await menu.loadMenuEntries()
            }
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
}

#Preview {
    ContentView()
        .environment(MenuManager(webservice: Webservice(apiSystem: .dev)))
}
