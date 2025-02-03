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
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderID: Int) async throws {
        let deleteorder = try await webservice.deleteOrder(orderID: orderID)
        orders = orders.filter { $0.id != deleteorder.id }
    }
    
}
