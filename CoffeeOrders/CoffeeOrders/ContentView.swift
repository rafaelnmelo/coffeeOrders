//
//  ContentView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 14/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: CoffeeModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("Sem pedidos!").accessibilityIdentifier("noOrdersText")
                } else {
                    List(model.orders) { order in
                        OrderCellView(order: order)
                    }
                }
            }.task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fazer pedido") {
                        isPresented = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
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
