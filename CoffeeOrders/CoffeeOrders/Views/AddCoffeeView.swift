//
//  AddCoffeeView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import SwiftUI

struct AddCoffeeView: View {
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    var body: some View {
        Form {
            TextField("Seu nome", text: $name)
                .accessibilityIdentifier("name")
            TextField("Café", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            TextField("Preço", text: $price)
                    .accessibilityIdentifier("price")
            Picker("Tamanho", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue).tag(size)
                }
            }.pickerStyle(.segmented)
            
            Button("Fazer pedido") {
                
            }.accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
        }
    }
}

#Preview {
    AddCoffeeView()
}
