//
//  MemorySafetyTests.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 09.05.26.
//



import Foundation
import Testing
import Harmonize
import HarmonizeSemantics


@Suite("Memory Safety Tests")
@MainActor
struct MemorySafetyTests {
    

    @Test("Closures should capture 'self' weakly to prevent retain cycles")
    func shouldCaptureSelfWeaklyToPreventRetainCycles() {
        let message = "Retain cycle detected: closure captures 'self' strongly. Use '[weak self]' or '[unowned self]' to prevent memory leaks."
        
        Harmonize
            .productionCode()
            .classes()
            .withNameEndingWith("ViewModel", "Service", "Manager", "View", "Coordinator", "Builder")
            .functions()
            .closures()
            .filter(\.hasSelfReference)
            .filter { closure in
                !closure.isCapturingWeak(valueOf: "self") && !closure.isCapturingUnowned(valueOf: "self")
            }
            .assertEmpty(message: message)
    }
}
