
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
            .onChange(of: authBuilder.status, initial: true) {
                if case .loggedIn = authBuilder.status {
                    hideKeyboard()
                }
            }
        }
    }
}
