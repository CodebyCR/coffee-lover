//
//  SearchCategorieGrid.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 23.12.25.
//

import SwiftUI


 


struct SearchCategoryGrid: View {
    
    @Binding var lookupValue: String
    
    
    var body: some View {
        ScrollView {
            
            Grid {
                
                GridRow {
                    SearchCategoryCell(category: .latest,
                                       color: getColorForCategory(.latest))
                    .onTapGesture {
                        setLookupValue(.latest)
                    }
                    
                    SearchCategoryCell(category: .favorites,
                                        color: getColorForCategory(.favorites))
                    .onTapGesture {
                        setLookupValue(.favorites)
                    }
                }
                
                GridRow {
                    SearchCategoryCell(category: .drinks,
                                       color: getColorForCategory(.drinks))
                    .onTapGesture {
                        setLookupValue(.drinks)
                    }
                    
                    SearchCategoryCell(category: .food,
                                       color: getColorForCategory(.food))
                    .onTapGesture {
                        setLookupValue(.food)
                    }
                }
                
                GridRow {
                    SearchCategoryCell(category: .vaggie,
                                       color: getColorForCategory(.vaggie))
                    .onTapGesture {
                        setLookupValue(.vaggie)
                    }
                }

                
                
            }
            

            .padding(8)
        }
        
    }
    
    private func setLookupValue(_ category: SearchCategoryType) {
        lookupValue = category.rawValue
    }
    
    private func getColorForCategory(_ category: SearchCategoryType) -> Color {
        switch category {
        case .latest:
            return .gray
        case .favorites:
            return .yellow
        case .drinks:
            return .brown
        case .food:
            return .orange
        case .vaggie:
            return .green
        }
    }
    
}

#Preview {
    SearchCategoryGrid(lookupValue: .constant("") )
}
