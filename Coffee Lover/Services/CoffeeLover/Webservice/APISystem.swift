//
//  APISystem.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation

public struct APISystem: ~Copyable, Sendable{
    public let baseURL: URL

    public static var dev: APISystem {
        return APISystem(baseURL: URL(fileURLWithPath: "http://127.0.0.1:8080/test"))
    }

    public static var productiv: APISystem {
        return APISystem(baseURL: URL(fileURLWithPath: "http://127.0.0.1:8080/prod"))
    }
}
