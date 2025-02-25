//
//  OrderDetailView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 25/02/25.
//

import SwiftUI

//MARK: - CLASS
struct OrderDetailView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented = false
    @Environment(\.dismiss) private var dismiss
    
    let orderID: Int
    
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
                            Task {
                                await deleteOrder()
                            }
                        }
                        Button("Modificar") {
                            isPresented = true
                        }.accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                    
                }.sheet(isPresented: $isPresented, content: {
                    AddCoffeeView(order: order)
                })
            }
            Spacer()
        }.padding()
    }
    
}

//MARK: - FUNCTIONS
extension OrderDetailView {
    private func deleteOrder() async {
        do {
            try await model.deleteOrder(orderID)
            dismiss()
        } catch {
            print(error)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    var config = Configuration()
    return OrderDetailView(orderID: 1).environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}
