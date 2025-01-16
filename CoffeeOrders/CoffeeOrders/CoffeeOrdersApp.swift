//
//  CoffeeOrdersApp.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 14/01/25.
//

import SwiftUI

@main
struct CoffeeOrdersApp: App {
    
    @StateObject private var model: CoffeeModel
    
    init() {
        var config = Configuration()
        let webservice = Webservice(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
