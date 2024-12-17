//
//  ShoppingCard.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct ShoppingCard: Sendable {
    private(set) var items: [CoffeeModel] = []

    public mutating func add(_ item: CoffeeModel) {
        items.append(item)
    }

    public mutating func remove(with id: UInt16) {
        items.removeAll { $0.id == id }
    }

    public func total() -> Float64 {
        items.map { $0.price }.reduce(0, +)
    }

    public func order() {}
}
