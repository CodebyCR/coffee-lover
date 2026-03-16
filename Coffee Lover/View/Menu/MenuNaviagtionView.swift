//
//  MenuNaviagtionView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 02.03.25.
//

import Coffee_Kit
import SwiftUI

struct MenuNaviagtionView: View {
    @Binding var lookupValue: String
    
    init(){
        self._lookupValue = .constant("")
    }

    init(filteredOn lookupValue: Binding<String>) {
        self._lookupValue = lookupValue
    }
    
    
    var body: some View {
        NavigationStack {
//            VStack {
            MenuListView(lookupValue: $lookupValue)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.brown)
//            }
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
