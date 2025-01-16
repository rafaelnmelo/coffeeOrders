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
            List(model.orders) { order in
                OrderCellView(order: order)
            }.task {
                await populateOrders()
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
    ContentView().environmentObject(CoffeeModel(webservice: Webservice()))
}
