//
//  Order.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 14/01/25.
//

import Foundation

enum CoffeorderError: Error {
    case invalidOrderID
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable, Identifiable, Hashable {
    
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
}
