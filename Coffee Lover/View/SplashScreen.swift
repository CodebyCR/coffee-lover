//
//  SplashScreen.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 26.06.25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: [.brown, .brown.opacity(0.6)]), startPoint: .bottomLeading, endPoint: .top)
                .ignoresSafeArea()

            VStack {



                Text("Coffee Lover")
                    .font(.system(size: 48, weight: .bold))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.8))
                            .shadow(radius: 10)
                    )
                    .foregroundColor(.brown)
                    .padding()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0), value: UUID())

                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.brown)
                    .brightness(0.24)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .offset(y: -200)


            }
        }

    }
}

#Preview {
    SplashScreen()
}
