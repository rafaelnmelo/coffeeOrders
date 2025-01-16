//
//  NumberFormatter+Extensions.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
}
