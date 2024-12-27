//
//  Coffee_LoverTests.swift
//  Coffee LoverTests
//
//  Created by Christoph Rohde on 20.10.24.
//

import Foundation
import Testing
@testable import Coffee_Lover

struct Coffee_LoverTests {

    @Test func decodingCoffeTest() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.

        let ressource = """
        {
            "id":1,
            "name":"Cappuccino",
            "price":3.5,
            "metadata":{
                "created_at":"2024-11-28 19:45:04",
                "updated_at":"2024-12-27 17:57:37",
                "tag_ids":[null]
            }
        }
       """

        let data = Data(ressource.utf8)
        let coffee = try await JSONDecoder().decode(CoffeeModel.self, from: data)

        #expect(coffee.id == 1)

    }

}
