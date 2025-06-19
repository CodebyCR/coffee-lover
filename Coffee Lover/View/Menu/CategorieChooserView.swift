//
//  CategorieChooserView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.05.25.
//

import Coffee_Kit
import SwiftUI

struct CategorieChooserView: View {
    @Binding public var menuCategories: [MenuCategory]
    @Binding public var selectedCategory: MenuCategory

    var body: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.clear)
            .background(.ultraThinMaterial)
            .frame(height: 50)
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.brown)
                    .opacity(0.3)
            }
            .overlay {
                SegmentedPicker(
                    selection: $selectedCategory,
                    items: $menuCategories,
                    selectionColor: .brown
                ) { category in
                    Text(category.rawValue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                )
            }
            .padding([.bottom, .horizontal], 8)
    }
}

#Preview {
    CategorieChooserView(
        menuCategories: .constant(MenuCategory.allCases),
        selectedCategory: .constant(MenuCategory.allCases.first!)
    )
    .preferredColorScheme(.dark)
}
