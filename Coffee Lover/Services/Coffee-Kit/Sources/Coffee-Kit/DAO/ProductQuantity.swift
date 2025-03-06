//
//  ProductQuantity.swift
//  Coffee-Kit
//
//  Created by Christoph Rohde on 06.03.25.
//

import Foundation

public struct ProductQuantity: Sendable, Identifiable {
    public var quantity: UInt8
    public var product: any Product
    public var id: UInt16 { product.id }
}
