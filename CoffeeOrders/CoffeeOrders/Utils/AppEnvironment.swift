//
//  AppEnvironment.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    case deleteOrder(Int)
    case updateOrder(Int)
    
    var path: String {
        switch self {
        case .allOrders: "/coffeeorders"
        case .placeOrder: "/coffeeorders"
        case .deleteOrder(_): "/coffeeorders"
        case .updateOrder(_): "/coffeeorders"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            URL(string: "https://demo4808138.mockable.io")!
        case .test:
            URL(string: "https://demo4808138.mockable.io")!
        }
    }
}
