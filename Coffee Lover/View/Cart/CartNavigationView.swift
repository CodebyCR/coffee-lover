//
//  CartNavigationView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//

import Coffee_Kit
import SwiftUI

struct CartNavigationView: View {
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        @Bindable var navManager = navigationManager
        
        NavigationStack(path: $navManager.cartPath) {
            VStack {
                ShoppingCartView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Cart")
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .navigationDestination(for: NavigationTarget.self) { target in
                        navigationManager.destinationView(for: target)
                            .environment(navigationManager)
                    }
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
    CartNavigationView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(OrderBuilder(for: UUID(uuidString: "03F35975-AF57-4691-811F-4AB872FDB51B")!))
}
