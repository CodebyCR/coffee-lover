//
//  MenuCategory.swift
//  Coffee-Kit
//
//  Created by Christoph Rohde on 10.03.25.
//

import Foundation

public enum MenuCategory: String, CaseIterable, Identifiable, Hashable, Codable, Sendable {
    case coffee = "Coffee"
    case cake = "Cake"
    case tea = "Tea"
    case snacks = "Snacks"

    public var id: Self { self }
}

extension MenuCategory: CustomDebugStringConvertible {
    public var debugDescription: String {
        rawValue
    }
}

public extension MenuCategory {
    static func get(by name: String) -> Self? {
        allCases.first { $0.rawValue == name }
    }
}
