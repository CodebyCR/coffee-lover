
import AuthenticationKit
import SwiftUI

struct MenuNavigationView: View {
    @Environment(AuthenticationBuilder.self) private var authBuilder
    @Environment(NavigationManager.self) private var navigationManager
    @Binding var lookupValue: String
    var embedInNavigationStack: Bool

    init(filteredOn lookupValue: Binding<String> = .constant(""), embedInNavigationStack: Bool = true) {
        self._lookupValue = lookupValue
        self.embedInNavigationStack = embedInNavigationStack
    }

    var body: some View {
        @Bindable var navManager = navigationManager

        if embedInNavigationStack {
            NavigationStack(path: $navManager.menuPath) {
                content
            }
            .background(
                Color
                    .brown
                    .gradient
            )
        } else {
            content
        }
    }

    @ViewBuilder
    private var content: some View {
        MenuListView(lookupValue: $lookupValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.brown)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        if case .loggedIn(let user) = authBuilder.status {
                            Section(user.name) {
                                Button(role: .destructive) {
                                    Task {
                                        await authBuilder.logout()
                                    }
                                } label: {
                                    Label("Abmelden", systemImage: "rectangle.portrait.and.arrow.right")
                                }
                            }
                        } else {
                            Button("Anmelden") {
                                authBuilder.status = .loggedOut
                            }
                        }
                    } label: {
                        Image(systemName: "person.circle")
                            .foregroundStyle(.white)
                    }
                }
            }
            .navigationDestination(for: NavigationTarget.self) { target in
                navigationManager.destinationView(for: target)
                    .environment(navigationManager)
            }
    }
}

//#Preview {
//    MenuNavigationView()
//        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
//        .environment(AuthenticationBuilder(
//            authManager: AutenticationManager(keychain: DefaultKeychainManager(), baseURL: URL(string: "http://localhost")!),
//            baseURL: URL(string: "http://localhost")!
//        ))
//}
