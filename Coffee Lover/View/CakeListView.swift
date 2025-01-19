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
            .task(priority: .background) {
                await menu.loadMenuEntries()

                //                await MainActor.run {
                //                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                //                        // animate menu entries...
                //
                //                    }
                //                }
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
        .environment(MenuManager(from: Webservice(inMode: .dev)))
}
