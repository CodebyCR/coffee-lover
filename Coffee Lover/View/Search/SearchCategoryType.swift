
import Foundation

enum SearchCategoryType : String{
    case latest = "Latest"
    case favorites = "Favorites"
    case drinks = "Drinks"
    case food   = "Food"
    case vegan = "Vegan"
}

extension SearchCategoryType: Identifiable {
    var id: Self { self }
} 

extension SearchCategoryType : Sendable {}

extension SearchCategoryType {
    var systemImageName: String {
        switch self {
        case .latest:
            return "clock.fill"
        case .favorites:
            return "star.fill"
        case .drinks:
            return "cup.and.heat.waves.fill"
        case .food:
            return "fork.knife"
        case .vegan:
            return "leaf.fill"
        }
    }
}

extension SearchCategoryType {
    var categoryColor: String {
        switch self {
        case .latest:
            return "gray"
        case .favorites:
            return "yellow"
        case .drinks:
            return "brown"
        case .food:
            return "orange"
        case .vegan:
            return "green"
        }
    }
}

    

extension SearchCategoryType: CaseIterable {
    static var allCases: [SearchCategoryType] {
        return [.latest, .favorites, .drinks, .food, .vegan]
    }
}

extension SearchCategoryType: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
   
