//
//  CurrencyFormatter.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 22.10.24.
//

import Foundation

public struct CurrencyFormatter {
    
    public static func formatAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.negativePrefix = formatter.minusSign
        guard let formattedAmount = formatter.string(from: NSNumber(value: amount)) else {
            return String(amount)
        }
        
        return formattedAmount
    }
}
