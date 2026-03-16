//
//  SearchCategoryCell.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 23.12.25.
//

import SwiftUI

struct SearchCategoryCell: View {
    private let coreRadius = CGSize(width: 12, height: 12)
    let categoryName: String
    let systemImage: String
    let categoryColor: Color
    
    init(category: SearchCategoryType) {
        self.categoryName = category.rawValue
        self.systemImage = category.systemImageName
        self.categoryColor = Color(category.categoryColor)
    }
    
    init(category: SearchCategoryType, color: Color) {
        self.categoryName = category.rawValue
        self.systemImage = category.systemImageName
        self.categoryColor = color
    }
    
    var body: some View {
        RoundedRectangle(cornerSize: coreRadius)
            .fill(categoryColor.gradient)
            .frame(height: 150)
            .overlay {
                VStack {
                    Image(systemName: systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white.opacity(0.7))
                    
                                        
                    Text(categoryName)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            
    }
}

#Preview {
    SearchCategoryCell(category: .vaggie)
        .frame(maxWidth: 200)
}
