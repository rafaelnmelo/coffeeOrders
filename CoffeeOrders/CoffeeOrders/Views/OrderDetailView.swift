//
//  OrderDetailView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 25/02/25.
//

import SwiftUI

struct OrderDetailView: View {
    
    let orderID: Int
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            if let order = model.orderByID(orderID) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack {
                        Spacer()
                        Button("Apagar", role: .destructive) {
                            
                        }
                        Button("Modificar") {
                            isPresented = true
                        }.accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                    
                }.sheet(isPresented: $isPresented, content: {
                    AddCoffeeView()
                })
            }
            Spacer()
        }.padding()
    }
    
}

#Preview {
    var config = Configuration()
    return OrderDetailView(orderID: 1).environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}
