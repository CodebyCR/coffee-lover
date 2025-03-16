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
                MenuListView()
                    .tag(MenuNavigationEntry.coffee)
                    .navigationBarTitleDisplayMode(.inline)
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
