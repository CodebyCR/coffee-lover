//
//  Coffee_LoverApp.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Coffee_Kit
import Authentication_Kit
import SwiftUI

@main
struct Coffee_LoverApp: App {
    private let keychain = DefaultKeychainManager()
    private let authManager: AutenticationManager
    private let baseURL = URL(string: "http://cr-mac.local:8080/test/authentication")!
    
    @State private var authBuilder: AuthenticationBuilder
    @State var menuManager: MenuManager
    @State var orderBuilder = OrderBuilder(for: UUID(uuidString: "03F35975-AF57-4691-811F-4AB872FDB51B")!)
    @State var orderManager: OrderManager
    @State var imageManager: ImageManager
    @State private var showSplashScreen = true
    
    init() {
        let manager = AutenticationManager(keychain: keychain, baseURL: baseURL)
        self.authManager = manager
        
        let webserviceProvider = WebserviceProvider(inMode: .dev, authManager: manager)
        
        self.menuManager = MenuManager(from: webserviceProvider)
        self.orderManager = OrderManager(from: webserviceProvider)
        self.imageManager = ImageManager(from: webserviceProvider)
        
        // Initialisierung des Builders mit dem Manager
        _authBuilder = State(initialValue: AuthenticationBuilder(authManager: manager, baseURL: baseURL))
    }

    var body: some Scene {
        WindowGroup {
            // MARK: - Splash Screen
            ZStack {
                if showSplashScreen {
                    SplashScreen()
                        .transition(.opacity)

                        .onAppear {
                            withAnimation(.easeOut(duration: 2.5)) {
                                showSplashScreen = false
                            }
                        }


                }
                else {
                    Group {
                        switch authBuilder.status {
                        case .loggedIn(let user):
                            //MainView(user: user)
                            ContentView()
                                .environment(menuManager)
                                .environment(orderBuilder)
                                .environment(orderManager)
                                .environment(imageManager)
                                .environment(authBuilder)
                        case .idle, .loading, .error, .loggedOut:
                            LoginView()
                                .environment(authBuilder)
                        }
                    }
                    
         
                }
            }
            .task {
                // Fill cache
                await menuManager.fillUpCache()

            }
        }
    }
}


struct MainView: View {
    let user: User
    @Environment(AuthenticationBuilder.self) private var authBuilder
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Willkommen, \(user.name)!")
                    .font(.title)
                
                Text("E-Mail: \(user.email)")
                
                Button("Abmelden") {
                    authBuilder.status = .loggedOut
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Dashboard")
        }
    }
}
