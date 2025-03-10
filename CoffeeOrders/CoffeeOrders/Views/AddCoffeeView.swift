//
//  AddCoffeeView.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import SwiftUI

//MARK: - CLASS
struct AddCoffeeView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: CoffeeModel
    
    var order: Order? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(errors.name.isNotEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                TextField("Café", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                
                TextField("Preço", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(!errors.price.isEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                
                Picker("Tamanho", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                            .foregroundStyle(.red)
                    }
                }.pickerStyle(.segmented)
                
                Button(order != nil ? "Atualizar" : "Fazer pedido") {
                    
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                    
                }.accessibilityIdentifier("placeOrderButton")
                    .centerHorizontally()
            }.navigationTitle(order != nil ? "Atualizar pedido" : "Pedir café")
                .onAppear {
                    populateExistingOrders()
                }
        }
    }
}

//MARK: - FUNCTIONS
extension AddCoffeeView {
    
    private func placeOrder(_ order: Order) async {
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func updateOrder(_ editedOrder: Order) async {
        do {
            try await model.updateOrder(editedOrder)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func populateExistingOrders() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeeSize = order.size
        }
    }
    
    private func saveOrUpdate() async {
        if let order {
            var editedOrder = order
            editedOrder.name = name
            editedOrder.total = Double(price) ?? 0.0
            editedOrder.coffeeName = coffeeName
            editedOrder.size = coffeeSize
            await updateOrder(editedOrder)
        } else {
            let order = Order(name: name,
                              coffeeName: coffeeName,
                              total: Double(price) ?? 0.0,
                              size: coffeeSize)
            await placeOrder(order)
        }
        dismiss()
    }
}

//MARK: - VALIDATIONS
struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

extension AddCoffeeView {
    var isValid: Bool {
        
        errors = AddCoffeeErrors()
        
        // NOT a business rule, just UI validation
        if name.isEmpty {
            errors.name = "Nome não pode estar vazio!"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Nome do café não pode estar vazio!"
        }
        
        if price.isEmpty {
            errors.price = "Preço não pode estar vazio!"
        } else if !price.isNumeric {
            errors.price = "Preço precisa ser um número"
        } else if price.isLessThan(1) {
            errors.price = "Preço precisa ser maior que 0"
        }
        
        return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
    }
}

//MARK: - PREVIEW
#Preview {
    AddCoffeeView()
}
