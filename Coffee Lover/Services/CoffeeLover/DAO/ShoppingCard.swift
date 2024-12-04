//
//  ShoppingCard.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 04.12.24.
//
import Foundation

public struct ShoppingCard: Sendable {
    private(set) var items: [Product] = []

    public mutating func add(_ item: Product) {
        items.append(item)
    }

    public func remove() {}

    public func order() {}

}
