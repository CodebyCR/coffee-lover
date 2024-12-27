//
//  ProductStore.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 27.12.24.
//

public struct ProductStore: Sendable {
    private var products: [String : [any Product]] = [:]

    public init() {
        products = [:]
    }

    public mutating func add(_ product: consuming some Product, to category: consuming String) {
        products[category]?.append(consume product)
    }

    public func getProducts(for category: String) -> [any Product] {
        return products[category] ?? []
    }

    public func getCategories() -> [String] {
        return Array(products.keys)
    }

    public func getProducts() -> [any Product] {
        return products.values.flatMap { $0 }
    }

    public mutating func clear() {
        products.removeAll()
    }

    public mutating func remove(_ product: some Product, from category: String) {
        products[category]?.removeAll { $0.id == product.id }
    }

    public mutating func remove(_ category: String) {
        products.removeValue(forKey: category)
    }

    public func map<T>(_ transform: (any Product) -> T) -> [T] {
        products.values.flatMap { $0 }.map(transform)
    }

    public func filter(_ isIncluded: (any Product) -> Bool) -> [any Product] {
        products.values.flatMap { $0 }.filter(isIncluded)
    }

    public func reduce<T>(_ initialResult: T, _ nextPartialResult: (T, any Product) -> T) -> T {
        products.values.flatMap { $0 }.reduce(initialResult, nextPartialResult)
    }

    public func forEach(_ body: (any Product) -> Void) {
        products.values.flatMap { $0 }.forEach(body)
    }

    public func contains(where predicate: (any Product) -> Bool) -> Bool {
        products.values.flatMap { $0 }.contains(where: predicate)
    }

    public func total() -> Float64 {
        products.values.flatMap { $0 }.map { $0.price }.reduce(0, +)
    }

}

// MARK: - Codable

extension ProductStore: Codable {
    enum CodingKeys: String, CodingKey {
        case products
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = [:]
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }

}


