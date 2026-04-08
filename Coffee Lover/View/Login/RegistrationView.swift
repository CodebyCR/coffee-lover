//
//  SwiftUIView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

import SwiftUI
import Authentication_Kit

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AuthenticationBuilder.self) private var authBuilder

    var body: some View {
        @Bindable var builder = authBuilder
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.brown.opacity(0.7), .brown]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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

                    TextField("", text: $builder.email, prompt: Text("Email").foregroundStyle(.gray.opacity(0.5)))
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundStyle(.black)

                    Group{
                        SecureField("", text: $builder.password, prompt: Text("********")
                            .foregroundStyle(.gray.opacity(0.5)))

                        
                        SecureField("", text: $builder.passwordRetyped, prompt: Text("********")
                            .foregroundStyle(.gray.opacity(0.5)))
                 
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                }
                .padding(.horizontal)

                Button(action: {
                    Task {
                        await authBuilder.register()
                        if case .loggedIn = authBuilder.status {
                            dismiss()
                        }
                    }
                }) {
                    if case .loading = authBuilder.status {
                        ProgressView()
                            .tint(.brown)
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
                    dismiss()
                }) {
                    Text("Already have an account? \(Text("Log In").fontWeight(.semibold)) here")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            authBuilder.status = .idle
        }
        .onDisappear {
            authBuilder.status = .idle
        }
    }
}

// Preview for RegistrationView
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
