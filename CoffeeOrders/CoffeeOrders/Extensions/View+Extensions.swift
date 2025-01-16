//
//  View+Extensions.swift
//  CoffeeOrders
//
//  Created by Rafael Nunes on 16/01/25.
//

import SwiftUI

extension View {
    
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        switch value {
            case true:
                self
            case false:
                EmptyView()
        }
    }
}
