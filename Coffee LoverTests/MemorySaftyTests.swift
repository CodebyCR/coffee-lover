//
//  MemorySaftyTests.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 29.04.25.
//

import Foundation
import Harmonize
import XCTest

final class MemorySaftyTests: XCTestCase {

    public func testShouldCaptureSelfWeaklyOnViewModels() {
        let message = "'self' should capture weakly in closures at this place."
        let suffixes = ["ViewModel", "Service", "Manager"]
        let memoryLeakCanidates = Harmonize
            .productionCode()
            .classes()
            .filter { clazz in
                suffixes.contains { clazz.name.hasSuffix($0) }
            }

        print("Found \(memoryLeakCanidates.count) candidates for memory leaks.")

        memoryLeakCanidates
            .functions()
            .filter(\.hasAnyClosureWithSelfReference)
            .assertTrue(message: message) {
                $0.closures()
                    .filter(\.hasSelfReference)
                    .allSatisfy { $0.isCapturingWeak(valueOf: "self") }
            }
    }
}
