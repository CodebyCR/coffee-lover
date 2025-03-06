//
//  CoffeeListView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//

//
//  CoffeeListContent.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.01.25.
//
import Coffee_Kit
import SwiftUI

@MainActor
struct CoffeeListView: View {

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                CoffeeListSubView()
            }
        }
        .background(
            Color
                .brown
                .gradient
        )

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Coffee")
                        .foregroundStyle(.white)
                        .padding(4)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    CoffeeListView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
