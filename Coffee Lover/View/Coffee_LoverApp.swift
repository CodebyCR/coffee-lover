

import SwiftUI
import AuthenticationKit
import ProductKit
import ImageKit
import OrderKit

@main
struct Coffee_LoverApp: App {
    private let keychain = DefaultKeychainManager()
    private let authManager: AutenticationManager
    
    
    @State var authBuilder: AuthenticationBuilder
    @State var menuManager: MenuManager
    @State var orderManager: OrderManager
    @State var imageManager: ImageManager
    @State var navigationManager = NavigationManager.shared
    @State private var showSplashScreen = true
    
    init() {
        let databaseAPI: DatabaseAPI = .dev
        let baseURL = databaseAPI.baseURL.appendingPathComponent("authentication")
        let manager = AutenticationManager(keychain: keychain, databaseAPI: databaseAPI)
        let webserviceProvider = WebserviceProvider(inMode: .dev, autheticationManager: manager)
        self.authManager = manager
        self.menuManager = MenuManager(from: webserviceProvider)
        self.orderManager = OrderManager(from: webserviceProvider)
        self.imageManager = ImageManager(from: webserviceProvider)
        self.authBuilder = AuthenticationBuilder(webserviceProvider: webserviceProvider)
    }

    var body: some Scene {
        WindowGroup {
            // MARK: - Splash Screen
            ZStack {
                if showSplashScreen {
                    SplashScreen()
                        .transition(.asymmetric(insertion: .opacity, removal: .scale(scale: 1.5).combined(with: .opacity)))
                        .zIndex(1)
                }
                else {
                    Group {
                        switch authBuilder.status {
                        case .loggedIn(let user):
                            ContentView()
                                .environment(navigationManager)
                                .environment(authBuilder)
                                .environment(menuManager)
                                .environment(OrderBuilder(for: user.id))
                                .environment(orderManager)
                                .environment(imageManager)
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
                async let menuCache: () = menuManager.fillUpCache()
                async let persistentLogin: () = authBuilder.checkPersistentLogin()
                async let minDelay: () = {
                    try? await Task.sleep(for: .seconds(2.0))
                }()
                
                _ = await (menuCache, persistentLogin, minDelay)
                
                withAnimation(.easeInOut(duration: 0.8)) {
                    showSplashScreen = false
                }
            }
            .onChange(of: authBuilder.status, initial: true) {
                if case .loggedIn = authBuilder.status {
                    hideKeyboard()
                }
            }
        }
    }
}
