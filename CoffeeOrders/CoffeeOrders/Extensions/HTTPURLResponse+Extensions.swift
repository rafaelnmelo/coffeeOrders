//
//  HTTPURLResponse+Extensions.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 25/02/25.
//

import Foundation

extension HTTPURLResponse {
    func debug(data: Data?) {
        debugPrint(terminator: "\n\n")
        debugPrint("----------------- RESPOSTA ---------------------", terminator: "\n")
        
        // Exibe o código da resposta e URL da resposta (se disponível)"
        if let url = self.url {
            debugPrint("\(self.statusCode): \(url)")
        }
        
        debugPrint(terminator: "\n")
        
        // Exibe os dados da resposta (se disponíveis)
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            debugPrint("Dados da resposta: \(dataString)")
        }
        
        debugPrint(terminator: "\n")
        
        // Exibe o tipo de mídia (se disponível)
        if let mimeType = self.mimeType {
            debugPrint("Tipo de Mídia: \(mimeType)")
        }
        
        // Exibe o comprimento do conteúdo (se disponível)
        let contentLength = self.expectedContentLength
        debugPrint("Comprimento do conteúdo: \(contentLength) bytes")
        
        debugPrint(terminator: "\n")
        
        // Exibe os cabeçalhos HTTP
        debugPrint(" Cabeçalhos HTTP ----------------")
        for (key, value) in self.allHeaderFields {
            print("\(key): \(value)")
        }
    }
}
