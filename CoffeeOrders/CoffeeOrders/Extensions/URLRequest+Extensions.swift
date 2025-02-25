//
//  URLRequest+Extensions.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 25/02/25.
//

import Foundation

extension URLRequest {
    func debug() {
        print(terminator: "\n\n")
        print("----------------- REQUISIÇÃO ---------------------")
        
        // Exibe o método HTTP e URL da requisição"
        if let method = self.httpMethod, let url = self.url {
            print("\(method): \(url)", terminator: "\n\n")
        }
        
        // Exibe os cabeçalhos HTTP
        if let headers = self.allHTTPHeaderFields {
            print("Cabeçalhos HTTP")
            print(headers, terminator: "\n\n")
        }
        
        // Exibe o corpo da requisição
        if let body = String(data: self.httpBody ?? Data(), encoding: .utf8) {
            print("Parametros")
            print(body, terminator: "\n\n")
        }

        print("--------------------------------------------------", terminator: "\n\n")
    }
}
