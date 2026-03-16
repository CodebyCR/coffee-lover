//
//  LoginView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

 import SwiftUI
 import Coffee_Kit

 struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showRegistration = false
    let coffeeBrownLight = Color(rgb: CoffeeColor.coffeeBrownLight.getRGB())
    let coffeeBrownDark = Color(rgb: CoffeeColor.coffeeBrownDark.getRGB())
    let coffeeAccent = Color(rgb: CoffeeColor.coffeeAccent.getRGB())

    let rawGradient = Color.brown.gradient
    // from raw gradient to Gradient
    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color.brown, location: 0.0),
        Gradient.Stop(color: Color.brown.opacity(0.8), location: 1.0)
    ])

    var body: some View {
        NavigationView {
            ZStack {
                // Background mit Coffee-Thema
                LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Image(systemName: "cup.and.saucer.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    Text("Willkommen zurück!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    VStack(spacing: 15) {
                        TextField("E-Mail", text: $viewModel.email)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .tint(coffeeBrownDark) // Text cursor color

                        SecureField("Passwort", text: $viewModel.password)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .tint(coffeeBrownDark) // Text cursor color
                    }
                    .padding(.horizontal)

                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("Anmelden")
                            .font(.headline)
                            .foregroundColor(coffeeBrownDark)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(coffeeAccent)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Fehlermeldung anzeigen
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Spacer()

                    Button(action: {
                        showRegistration = true
                    }) {
                        Text("Noch kein Konto? Registrieren")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showRegistration) {
                RegistrationView()
            }
        }
    }
 }

// Preview für LoginView
 struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
 }
