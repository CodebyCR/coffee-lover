//
//  CakeListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//


import SwiftUI
import Coffee_Kit

struct CakeListView: View {
    @Environment(MenuManager.self) private var menu
    @State private var cakes: [CakeModel] = []


    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    List {
                        ForEach(cakes, id: \.id) { entry in
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
                await MainActor.run {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        // animate menu entries...
                        menu.cakes.forEach { cake in
                            print("Adding \(cake.name)...")
                            cakes.append(cake)
                        }

                    }
                }
            }

            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Cake")
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
    CakeListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
