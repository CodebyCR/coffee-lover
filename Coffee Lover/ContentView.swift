//
//  ContentView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI


@MainActor
struct ContentView: View {

//    @State private var choosedProducts: [Product] = []

    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
            CoffeeListView()
//            CakeListView()
//        }
    }
}

#Preview {
    ContentView()
}
