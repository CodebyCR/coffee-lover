//
//  CakeModel.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 27.12.24.
//

import Foundation

@DebugDescription
public struct CakeModel: Product, Codable, Hashable {
    public let id: UInt16
    public let name: String
    public let price: Float64
    public let metadata: Metadata
    public var menuCategory: MenuCategory
    public var debugDescription: String {
        "CakeModel: id=\(id), name=\(name), price=\(price), metadata=\(metadata)"
    }

    // MARK: - Initializer

    public init() {
        id = 0
        name = "Caffee"
        price = 3.20
        metadata = Metadata()
        menuCategory = .cake
    }

    // MARK: - Equatable

    public static func == (lhs: CakeModel, rhs: CakeModel) -> Bool {
        lhs.id == rhs.id
    }
}
