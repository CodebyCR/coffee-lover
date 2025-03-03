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
    @Environment(MenuManager.self) private var menu

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                List {
                    ForEach(menu.coffees, id: \.id) { entry in
                        MenuEntry(productEntry: entry)
                            .swipeActions {
                                Button("Add") {
                                    print("Add \(entry.name) to cart ...")
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
            await addMenuEntiesAnimated()
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
