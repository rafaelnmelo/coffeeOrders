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
        //FIXME: Mock
        orders.append(Order(id: 1,
                            name: "Rafan",
                            coffeeName: "Expresso",
                            total: 4.5,
                            size: CoffeeSize.medium))
    }
    
    func orderByID(_ id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        
        return orders[index]
    }
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderID: Int) async throws {
        //FIXME: Remover mock
        //        let deleteorder = try await webservice.deleteOrder(orderID: orderID)
        //        orders = orders.filter { $0.id != deleteorder.id }
        orders = []
    }
    
    func updateOrder(_ order: Order) async throws {
        //FIXME: Remover mock
        //        let updatedOrder = try await webservice.updateOrder(order)
        //        guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) else {
        //            throw CoffeorderError.invalidOrderID
        //        }
        orders[0] = order
    }
    
}
