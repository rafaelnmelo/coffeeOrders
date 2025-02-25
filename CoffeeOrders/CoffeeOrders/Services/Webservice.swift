//
//  Webservice.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 14/01/25.
//

import Foundation

//MARK: - NETWORK ERROR -
enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

//MARK: - CLASS -
class Webservice {
    
    private var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func updateOrder(_ order: Order) async throws -> Order {
        guard let orderID = order.id else {
            throw NetworkError.badRequest
        }
        
        guard let url = URL(string: Endpoints.updateOrder(orderID).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.debug()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        httpResponse.debug(data: data)
        
        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return updatedOrder
    }
    
    func deleteOrder(orderID: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(orderID).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.debug()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        httpResponse.debug(data: data)
        
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return deletedOrder
    }
    
    func placeOrder(order: Order) async throws -> Order {
        
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        request.debug()
        
        let (data, response) = try await URLSession.shared.data(for: request)
    
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        httpResponse.debug(data: data)
        
        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return newOrder
    }
    
    func getOrders() async throws -> [Order] {
        
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        let request = URLRequest(url: url)
        request.debug()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        httpResponse.debug(data: data)
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return orders
    }
    
}
