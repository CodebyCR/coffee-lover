//
//  MenuNavigationView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 02.03.25.
//

import Coffee_Kit
import Authentication_Kit
import SwiftUI

struct MenuNavigationView: View {
    @Environment(AuthenticationBuilder.self) private var authBuilder
    @Environment(NavigationManager.self) private var navigationManager
    @Binding var lookupValue: String

    init(){
        self._lookupValue = .constant("")
    }

    init(filteredOn lookupValue: Binding<String>) {
        self._lookupValue = lookupValue
    }


    var body: some View {
        @Bindable var navManager = navigationManager

        NavigationStack(path: $navManager.menuPath) {
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
        .background(
            Color
                .brown
                .gradient
        )
    }
}

#Preview {
    MenuNavigationView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(AuthenticationBuilder(
            authManager: AutenticationManager(keychain: DefaultKeychainManager(), baseURL: URL(string: "http://localhost")!),
            baseURL: URL(string: "http://localhost")!
        ))
}
