//
//  LoginView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

import SwiftUI
import Authentication_Kit

 struct LoginView: View {
    @Environment(AuthenticationBuilder.self) private var authBuilder
    @State private var showRegistration = false

    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color.brown, location: 0.0),
        Gradient.Stop(color: Color.brown.opacity(0.8), location: 1.0)
    ])

    var body: some View {
        @Bindable var builder = authBuilder
        
        NavigationStack {
            ZStack {
                LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    // Geste zum Schließen der Tastatur
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }

                VStack(spacing: 20) {
                    Spacer()

                    Image(systemName: "cup.and.saucer.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    Text("Welcome back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    VStack(spacing: 15) {
                        TextField("", text: $builder.email, prompt: Text("Email").foregroundStyle(.gray.opacity(0.5)))
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundStyle(.black)

                        SecureField("", text: $builder.password, prompt: Text("********").foregroundStyle(.gray.opacity(0.5)))
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal)

                    Button(action: {
                        Task {
                            await authBuilder.login()
                        }
                    }) {
                        if case .loading = authBuilder.status {
                            ProgressView()
                                .tint(.white)
                                .padding()
                        } else {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.brown)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .disabled(authBuilder.status == .loading)

                    // Show error message
                    if case .error(let error) = authBuilder.status {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .background(Color.white.opacity(0.8).cornerRadius(5))
                    }

                    Spacer()

                    Button(action: {
                        showRegistration = true
                    }) {
                        Text("No account yet? \(Text("Register").fontWeight(.semibold))")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showRegistration) {
                RegistrationView()
                    .environment(authBuilder)
            }
            .onAppear {
                authBuilder.status = .idle
            }
            .onChange(of: showRegistration) { _, newValue in
                if newValue {
                    authBuilder.status = .idle
                }
            }
        }
    }
 }

// Preview for LoginView
 struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
 }
