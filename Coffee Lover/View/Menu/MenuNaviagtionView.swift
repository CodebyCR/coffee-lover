//
//  MenuNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 02.03.25.
//

import Coffee_Kit
import SwiftUI

struct MenuNaviagtionView: View {
    var body: some View {
        NavigationStack {
            VStack {
                MenuListView()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .background(
            Color
                .brown
                .gradient
        )
    }
}

#Preview {
    MenuNaviagtionView()
        .environment(MenuManager(from: WebserviceProvider(inMode: .dev)))
}
