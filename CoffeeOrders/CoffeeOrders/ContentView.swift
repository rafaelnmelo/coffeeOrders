//
//  ContentView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 14/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    var body: some View {
        VStack {
            if model.orders.isEmpty {
                Text("Sem pedidos disponíveis").accessibilityIdentifier("noOrdersText")
            } else {
                List(model.orders) { order in
                    OrderCellView(order: order)
                }.task {
                    await populateOrders()
                }
            }
        }
        .padding()
    }
}

//MARK: - FUNCTIONS
extension ContentView {
    
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    var config = Configuration()
    return ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}
