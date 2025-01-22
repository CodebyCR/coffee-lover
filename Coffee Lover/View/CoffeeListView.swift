//
//  CoffeeListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//

import SwiftUI
import Coffee_Kit

@MainActor
struct CoffeeListView: View {
    @Environment(MenuManager.self) private var menu

    @State private var coffees: [CoffeeModel] = []


    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    List {
                        ForEach(coffees, id: \.id) { entry in
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
            .task(priority: .background) {

                for await coffee in await menu.coffeeSequence.loadAll() {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        // animate menu entries...
                            switch coffee {
                            case .failure(let error):
                                print(error)
                            case .success(let coffee):
                                print("Adding \(coffee.name)...")
                                coffees.append(coffee)
                            }
                    }
                }

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
    CoffeeListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
