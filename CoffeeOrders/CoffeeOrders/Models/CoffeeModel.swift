//
//  CoffeeModel.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import Foundation

@MainActor // - > Properties and functions to the main queue
class CoffeeModel: ObservableObject {
    
    let webservice: Webservice
    @Published private(set) var orders: [Order] = []
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
}
