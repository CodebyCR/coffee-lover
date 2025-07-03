//
//  Coffee_LoverApp.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import SwiftUI

@main
struct Coffee_LoverApp: App {
    @State var menuManager = MenuManager(from: WebserviceProvider(inMode: .dev))
    @State var orderBuilder = OrderBuilder(for: UUID(uuidString: "03F35975-AF57-4691-811F-4AB872FDB51B")!)
    @State var orderManager = OrderManager(from: WebserviceProvider(inMode: .dev))
    @State var imageManager = ImageManager(from: WebserviceProvider(inMode: .dev))
    @State private var showSplashScreen = true

    var body: some Scene {
        WindowGroup {
            // MARK: - Splash Screen
            ZStack {
                if showSplashScreen {
                    SplashScreen()
                        .transition(.opacity)
                        .task {
                            // Fill cache
                            await menuManager.fillUpCache()

                        }
                        .onAppear {
                            withAnimation(.easeOut(duration: 2.5)) {
                                showSplashScreen = false
                            }
                        }


                }
                else {
                    ContentView()
                        .environment(menuManager)
                        .environment(orderBuilder)
                        .environment(orderManager)
                        .environment(imageManager)
                }
            }
        }
    }
}
