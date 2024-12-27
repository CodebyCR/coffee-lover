//
//  CakeModel.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 27.12.24.
//

import Foundation

public struct CakeModel: Product, Codable, Hashable {
    public let id: UInt16
    public let name: String
    public let price: Float64
    public let metadata: Metadata

    public static func == (lhs: CakeModel, rhs: CakeModel) -> Bool {
        lhs.id == rhs.id
    }
}
