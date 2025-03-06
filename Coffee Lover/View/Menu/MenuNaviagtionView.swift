//
//  MenuNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 02.03.25.
//

import Coffee_Kit
import SwiftUI

enum MenuNavigationEntry: String {
    case coffee = "Coffee"
    case cake = "Cake"
}

struct MenuNaviagtionView: View {
    @State private var homeNavigationStack: [MenuNavigationEntry] = []

    var body: some View {
        NavigationStack(path: $homeNavigationStack) {
            VStack {
                CoffeeListView()
                    .tag(MenuNavigationEntry.coffee)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text(homeNavigationStack.last?.rawValue ?? "Coffee")
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .fontWeight(.bold)
                            }
                        }
                    }

                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 50)
                    .foregroundColor(.brown)
                    .overlay {
                        Text("Categorie Placeholder")
                            .foregroundStyle(.white)

                            .fontWeight(.bold)
                    }
                    .padding([.bottom, .horizontal], 16)
            }
        }
        .background(
            Color
                .brown
                .gradient
        )
    }
}

#Preview {
    MenuNaviagtionView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
