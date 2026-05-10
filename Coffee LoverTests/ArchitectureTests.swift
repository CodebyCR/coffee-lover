//
//  ArchitectureTests.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 09.05.26.
//



import Foundation
import Testing
import Harmonize
import HarmonizeSemantics


@Suite("Architecture Tests")
struct ArchitectureTests {
    
    @Test("Services and Managers should be declared as 'final'")
    func servicesShouldBeFinal() {
        Harmonize.productionCode()
            .classes()
            .withNameEndingWith("Service", "Manager")
            .withoutModifier(.final)
            .assertEmpty(message: "Services and Managers should be declared as 'final' to prevent unintended subclassing.")
    }
    
    @Test("The app should not depend on the Vapor framework directly")
    func appShouldNotImportVapor() {
        // Ensuring that the main app doesn't accidentally depend on the Vapor backend framework
        Harmonize.productionCode()
            .imports()
            .withName("Vapor")
            .assertEmpty(message: "The Coffee Lover app should not depend on the Vapor framework directly.")
    }
}