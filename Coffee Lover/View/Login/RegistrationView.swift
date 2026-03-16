//
//  SwiftUIView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

import SwiftUI
import Coffee_Kit

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss // Um die Ansicht zu schließen
    @StateObject private var viewModel = AuthViewModel() // Oder ein separates RegistrationViewModel
    let coffeeBrownLight = Color(rgb: CoffeeColor.coffeeBrownLight.getRGB())
    let coffeeBrownDark = Color(rgb: CoffeeColor.coffeeBrownDark.getRGB())
    let coffeeAccent = Color(rgb: CoffeeColor.coffeeAccent.getRGB())

    var body: some View {
        ZStack {
            // Background mit Coffee-Thema
            LinearGradient(gradient: Gradient(colors: [coffeeBrownLight, coffeeBrownDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Image(systemName: "person.badge.plus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                Text("Neues Konto erstellen")
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
                        .tint(coffeeBrownDark)

                    SecureField("Passwort", text: $viewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .tint(coffeeBrownDark)

                    SecureField("Passwort bestätigen", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .tint(coffeeBrownDark)
                }
                .padding(.horizontal)

                Button(action: {
                    Task {
                        await viewModel.register()
                        // Hier könnte eine Logik stehen, um die Registrierung abzuschließen und die Ansicht zu schließen
                        if viewModel.registrationSuccessful {
                            dismiss()
                        }
                    }
                }) {
                    Text("Registrieren")
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
                    dismiss()
                }) {
                    Text("Bereits ein Konto? Anmelden")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

// Preview für RegistrationView
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
