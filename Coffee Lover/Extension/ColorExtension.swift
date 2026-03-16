//
//  ColorExtension.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 05.07.25.
//

import SwiftUI

extension Color {
    init(rgb: (red: Double, green: Double, blue: Double)) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
}
