//
//  OrderNavigationView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 13.03.25.
//

import Coffee_Kit
import SwiftUI

struct OrderNavigationView: View {
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        @Bindable var navManager = navigationManager
        
        NavigationStack(path: $navManager.ordersPath) {
            VStack {
                OrderListView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Orders")
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .navigationDestination(for: NavigationTarget.self) { target in
                        navigationManager.destinationView(for: target)
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
    OrderNavigationView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
