//
//  SwiftUIView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

import SwiftUI
import Authentication_Kit

struct RegistrationView: View {
    @Environment(AuthenticationBuilder.self) private var authBuilder
    @Environment(NavigationManager.self) private var navigationManager
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case name, email, password, passwordRetyped
    }
    
    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color.brown, location: 0.0),
        Gradient.Stop(color: Color.brown.opacity(0.8), location: 1.0)
    ])

    var body: some View {
        @Bindable var builder = authBuilder
        
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    focusedField = nil
                }
            
            VStack(spacing: 20) {
                Spacer()

                Image(systemName: "person.badge.plus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                Text("Create new account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    TextField("", text: $builder.name, prompt: Text("Name").foregroundStyle(.gray.opacity(0.5)))
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .autocapitalization(.words)
                        .foregroundStyle(.black)
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)

                    TextField("", text: $builder.email, prompt: Text("Email").foregroundStyle(.gray.opacity(0.5)))
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundStyle(.black)
                        .focused($focusedField, equals: .email)
                        .submitLabel(.next)

                    Group {
                        SecureField("", text: $builder.password, prompt: Text("********")
                            .foregroundStyle(.gray.opacity(0.5)))
                            .focused($focusedField, equals: .password)
                            .submitLabel(.next)

                        SecureField("", text: $builder.passwordRetyped, prompt: Text("********")
                            .foregroundStyle(.gray.opacity(0.5)))
                            .focused($focusedField, equals: .passwordRetyped)
                            .submitLabel(.join)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                }
                .padding(.horizontal)
                .onSubmit {
                    switch focusedField {
                    case .name:
                        focusedField = .email
                    case .email:
                        focusedField = .password
                    case .password:
                        focusedField = .passwordRetyped
                    case .passwordRetyped:
                        focusedField = nil
                        Task {
                            await authBuilder.register()
                        }
                    default:
                        break
                    }
                }

                Button(action: {
                    focusedField = nil
                    Task {
                        await authBuilder.register()
                    }
                }) {
                    if case .loading = authBuilder.status {
                        ProgressView()
                            .tint(.white)
                            .padding()
                    } else {
                        Text("Register")
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
                    navigationManager.popToRoot(in: .auth)
                }) {
                    Text("Already have an account? \(Text("Log In").fontWeight(.semibold)) here")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            authBuilder.status = .idle
        }
        .onChange(of: authBuilder.status) {
            if case .loggedIn = authBuilder.status {
                focusedField = nil
                hideKeyboard()
            }
        }
    }
}

// Preview for RegistrationView
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environment(NavigationManager.shared)
    }
}
