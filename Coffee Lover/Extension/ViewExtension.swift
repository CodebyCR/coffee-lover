//
//  ViewExtension.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 11.04.26.
//

import SwiftUI

/// Dismisses the software keyboard.
/// This is a global function to ensure it can be called from both Views and the App struct.
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
