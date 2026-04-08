//
//  MenuNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 02.03.25.
//

import Coffee_Kit
import Authentication_Kit
import SwiftUI

struct MenuNaviagtionView: View {
    @Environment(AuthenticationBuilder.self) private var authBuilder
    @Binding var lookupValue: String
    
    init(){
        self._lookupValue = .constant("")
    }

    init(filteredOn lookupValue: Binding<String>) {
        self._lookupValue = lookupValue
    }
    
    
    var body: some View {
        NavigationStack {
//            VStack {
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
//            }
        }
        .background(
            Color
                .brown
                .gradient
        )
    }
}

#Preview {
    MenuNaviagtionView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
        .environment(AuthenticationBuilder(
            authManager: AutenticationManager(keychain: DefaultKeychainManager(), baseURL: URL(string: "http://localhost")!),
            baseURL: URL(string: "http://localhost")!
        ))
}
