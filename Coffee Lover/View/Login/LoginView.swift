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
    @Environment(NavigationManager.self) private var navigationManager
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email, password
    }

    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color.brown, location: 0.0),
        Gradient.Stop(color: Color.brown.opacity(0.8), location: 1.0)
    ])

    var body: some View {
        @Bindable var builder = authBuilder
        @Bindable var navManager = navigationManager
        
        NavigationStack(path: $navManager.authentication) {
            ZStack {
                LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        focusedField = nil
                    }

                loginContent(builder: $builder)
                    .onChange(of: authBuilder.status, initial: false) {
                        switch authBuilder.status {
                        case .loggedIn(_):
                            focusedField = nil
                        default:
                            break
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }
            .navigationDestination(for: NavigationTarget.self) { target in
                navigationManager.destinationView(for: target)
                    .environment(authBuilder)
                    .environment(navigationManager)
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: navManager.authentication.count)
            .navigationBarHidden(true)
            .onAppear {
                authBuilder.status = .idle
            }
        }
    }

    @ViewBuilder
    private func loginContent(builder: Bindable<AuthenticationBuilder>) -> some View {
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
                TextField("", text: builder.email, prompt: Text("Email").foregroundStyle(.gray.opacity(0.5)))
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .foregroundStyle(.black)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)

                SecureField("", text: builder.password, prompt: Text("********").foregroundStyle(.gray.opacity(0.5)))
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
            }
            .padding(.horizontal)
            .onSubmit {
                switch focusedField {
                case .email:
                    focusedField = .password
                case .password:
                    focusedField = nil
                    Task {
                        await authBuilder.login()
                    }
                default:
                    break
                }
            }

            Button(action: {
                focusedField = nil
                Task {
                    await authBuilder.login()
                }
            }) {
                switch authBuilder.status {
                case .loading:
                    ProgressView()
                        .tint(.white)
                        .padding()
                default:
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
                focusedField = nil
                navigationManager.navigate(to: .register, in: .auth)
            }) {
                Text("No account yet? \(Text("Register").fontWeight(.semibold))")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
        }
    }
 }

// Preview for LoginView
 struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
 }
