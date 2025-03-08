//
//  CoffeeListSubView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 06.03.25.
//

import Coffee_Kit
import SwiftUI

@MainActor
struct CoffeeListSubView: View {
    @Environment(MenuManager.self) private var menu
    @Environment(OrderBuilder.self) var orderBuilder: OrderBuilder

    var body: some View {
        List {
            if menu.coffees.isEmpty {
                ContentUnavailableView("No Internet connection.", systemImage: "wifi.exclamationmark.circle", description: Text("Please check your connection."))
            }

            ForEach(menu.coffees, id: \.id) { entry in

                NavigationLink(
                    destination: {
                        ProductDetailView(product: entry)
                    }, label: {
                        MenuEntry(productEntry: entry)
                            .swipeActions {
                                Button("Add") {
                                    print("Add \(entry.name) to cart ...")
                                    orderBuilder.addProduct(entry)
                                }
                            }
                    })
            }
        }
        .task(priority: .background) {
            await addMenuEntiesAnimated()
        }
    }

    fileprivate func addMenuEntiesAnimated() async {
        if !menu.coffees.isEmpty {
            return
        }

        for await coffee in await menu.coffeeSequence.loadAll() {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                // animate menu entries...
                switch coffee {
                case .failure(let error):
                    print(error)
                case .success(let coffee):
                    print("Adding \(coffee.name)...")
                    menu.coffees.append(coffee)
                }
            }
        }
    }
}

#Preview {
    CoffeeListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
