//
//  Coffee_LoverApp.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI

@main
struct Coffee_LoverApp: App {
    @State var menuManager = MenuManager(webservice: Webservice(apiSystem: .dev))

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(menuManager)
        }
    }
}
