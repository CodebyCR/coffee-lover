//
//  ContentView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import SwiftUI


@MainActor
struct ContentView: View {

    @State private var currentIndex = 0
//        @GestureState private var dragOffset: CGFloat = 0

     let list = ["Coffees", "Cakes"]

        var body: some View {
            NavigationStack {
                CoffeeListView()
//                VStack {
//                    ZStack {
//                        ForEach(list, id: \.self) { listType in
//                            switch listType {
//                            case "Coffees":
//
//                            case "Cakes":
//                                CakeListView()
//
//                            default:
//                                EmptyView()
//                            }
//                        }
//
//                    }
//                    .gesture(
//                        DragGesture()
//                            .onEnded({ value in
//                                let threshold: CGFloat = 50
//                                if value.translation.width > threshold {
//                                    withAnimation {
//                                        currentIndex = max(0, currentIndex - 1)
//                                    }
//                                } else if value.translation.width < -threshold {
//                                    withAnimation {
//                                        currentIndex = min(list.count - 1, currentIndex + 1)
//                                    }
//                                }
//                            })
//                    )
//                }
//                .navigationBarTitle("Menu")
//                .toolbar {
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {
//                            Button {
//                                withAnimation {
//                                    currentIndex = max(0, currentIndex - 1)
//                                }
//                            } label: {
//                                Image(systemName: "arrow.left")
//                                    .font(.title)
//                            }
//                            Spacer()
//                            Button {
//                                withAnimation {
//                                    currentIndex = min(list.count - 1, currentIndex + 1)
//                                }
//                            } label: {
//                                Image(systemName: "arrow.right")
//                                    .font(.title)
//                            }
//                        }
//                        .padding(.horizontal, 50)
//                    }
//                }
            }
        }
}

#Preview {
    ContentView()
}
