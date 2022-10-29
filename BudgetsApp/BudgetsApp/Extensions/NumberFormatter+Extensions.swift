//
//  NumberFormatter+Extensions.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
