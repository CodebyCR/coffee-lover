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
    
    @State var authBuilder: AuthenticationBuilder
    @State var menuManager: MenuManager
    @State var orderBuilder = OrderBuilder(for: UUID(uuidString: "03F35975-AF57-4691-811F-4AB872FDB51B")!)
    @State var orderManager: OrderManager
    @State var imageManager: ImageManager
    @State var navigationManager = NavigationManager.shared
    @State private var showSplashScreen = true
    
    init() {
        let manager = AutenticationManager(keychain: keychain, baseURL: baseURL)
        self.authManager = manager
        
        let webserviceProvider = WebserviceProvider(inMode: .dev, authManager: manager)
        self.menuManager = MenuManager(from: webserviceProvider)
        self.orderManager = OrderManager(from: webserviceProvider)
        self.imageManager = ImageManager(from: webserviceProvider)
        self.authBuilder = AuthenticationBuilder(authManager: manager, baseURL: baseURL)
    }

    var body: some Scene {
        WindowGroup {
            // MARK: - Splash Screen
            ZStack {
                if showSplashScreen {
                    SplashScreen()
                        .transition(.asymmetric(insertion: .opacity, removal: .scale(scale: 1.5).combined(with: .opacity)))
                        .zIndex(1) // Ensure splash stays on top during removal
                }
                else {
                    Group {
                        switch authBuilder.status {
                        case .loggedIn:
                            ContentView()
                                .environment(menuManager)
                                .environment(orderBuilder)
                                .environment(orderManager)
                                .environment(imageManager)
                                .environment(authBuilder)
                                .environment(navigationManager)
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                        case .idle, .loading, .error, .loggedOut:
                            LoginView()
                                .environment(authBuilder)
                                .environment(navigationManager)
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                    .animation(
                        .spring(response: 0.6, dampingFraction: 0.8),
                        value: authBuilder.status
                    )
                    
                }
            }
            // MARK: - Lifecycle Modifiers (Ganz außen!)
            .task {
                
                // Startet sofort beim App-Launch
                async let menuCache: () = menuManager.fillUpCache()
                async let persistentLogin: () = authBuilder.checkPersistentLogin()
                
                // Parallel ausführen
                _ = await (menuCache, persistentLogin)
                
                
                do {
                    try await Task.sleep(for: .seconds(2.0))
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSplashScreen = false
                    }
                } catch {
                    print("Splash screen task cancelled: \(error)")
                }
            }
            // Hängt jetzt am ZStack und lauscht von Sekunde 0 an!
            .onChange(of: authBuilder.status, initial: false) {
                if case .loggedIn = authBuilder.status {
                    hideKeyboard()
                }
            }
        }
    }
}
