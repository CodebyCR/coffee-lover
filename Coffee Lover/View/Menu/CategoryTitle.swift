//
//  CategoryTitle.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 19.06.25.
//
import SwiftUI

struct CategoryTitle: View {
    let categoryTitle: String

    var body: some View {
        Text(categoryTitle)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.brown)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.clear)
    }
}

#Preview {
    CategoryTitle(categoryTitle: "Coffee")
        .preferredColorScheme(.dark)
}
