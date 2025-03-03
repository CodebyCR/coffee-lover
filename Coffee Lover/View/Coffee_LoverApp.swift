//
//  Coffee_LoverApp.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI
import Coffee_Kit

@main
struct Coffee_LoverApp: App {
    

    @State var menuManager = MenuManager(from: WebserviceProvider(inMode: .dev))

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(menuManager)
        }
    }
}
