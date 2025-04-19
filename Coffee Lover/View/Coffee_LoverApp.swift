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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(menuManager)
                .environment(orderBuilder)
                .environment(orderManager)
        }
    }
}
