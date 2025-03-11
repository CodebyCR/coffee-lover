//
//  CoffeeMenu.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

@DebugDescription
public struct CoffeeModel: Product, Codable, Hashable {
    public let id: UInt16
    public let name: String
    public let price: Float64
    public let metadata: Metadata
    public var menuCategory: MenuCategory
    public var debugDescription: String {
        "CoffeeModel: id=\(id), name=\(name), price=\(price), metadata=\(metadata)"
    }

    public static func == (lhs: CoffeeModel, rhs: CoffeeModel) -> Bool {
        lhs.id == rhs.id
    }

    // default init
    public init() {
        id = 0
        name = "Caffee"
        price = 3.20
        metadata = Metadata()
        menuCategory = .coffee
    }

    // MARK: - Codable

    // {"id":1,"name":"Cappuccino","price":3.5,"metadata":{"created_at":"2024-11-28 19:45:04","updated_at":"2024-12-27 17:57:37","tag_ids":[null]}}

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case metadata
        case menuCategory

        enum MetadataKeys: String, CodingKey {
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case tagIds = "tag_ids"
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UInt16.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Float64.self, forKey: .price)
        metadata = try container.decode(Metadata.self, forKey: .metadata)
        menuCategory = .coffee
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)

        var metadataContainer = container.nestedContainer(keyedBy: Metadata.CodingKeys.self, forKey: .metadata)
        try metadataContainer.encode(metadata.createdAt, forKey: .createdAt)
        try metadataContainer.encode(metadata.updatedAt, forKey: .updatedAt)
        try container.encode(menuCategory, forKey: .menuCategory)

        // try metadataContainer.encode(metadata.tagIds, forKey: .tagIds)
    }
}
