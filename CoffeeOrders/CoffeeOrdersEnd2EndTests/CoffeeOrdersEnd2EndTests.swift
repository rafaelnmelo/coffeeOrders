//
//  CoffeeOrdersEnd2EndTests.swift
//  CoffeeOrdersEnd2EndTests
//
//  Created by Rafael Nunes on 16/01/25.
//

import XCTest

final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_make_sure_no_orders_message_is_displayed() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV":"TEST"]
        app.launch()
        
        XCTAssertEqual("Sem pedidos disponíveis", app.staticTexts["noOrdersText"].label)
    }
}
