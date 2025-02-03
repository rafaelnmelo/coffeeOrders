//
//  CoffeeOrdersEnd2EndTests.swift
//  CoffeeOrdersEnd2EndTests
//
//  Created by Rafael Nunes on 16/01/25.
//

import XCTest

final class when_deleting_an_order: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Rafan")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Cafézin")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        // place the order
        placeOrderButton.tap()
    }
    
    func test_should_delete_order_successfully() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    // called after running each test
    override func tearDown() {
        Task {
            //could call a "clearOrders" endpoint
            /*guard let url = URL(string: "path", relativeTo: URL(string: "endpoint")!) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)*/
        }
    }
}

final class when_adding_a_new_coffee_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    // called before running each test
    override func setUp() {
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Rafan")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Cafézin")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        // place the order
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_in_list_successfully() throws {
        
        XCTAssertEqual("Rafan", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Cafézin (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("R$ 4,50", app.staticTexts["coffeePriceText"].label)
    }
    
    // called after running each test
    override func tearDown() {
        Task {
            //could call a "clearOrders" endpoint
            /*guard let url = URL(string: "path", relativeTo: URL(string: "endpoint")!) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)*/
        }
    }
    
}

final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_make_sure_no_orders_message_is_displayed() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV":"TEST"]
        app.launch()
        
        XCTAssertEqual("Sem pedidos disponíveis", app.staticTexts["noOrdersText"].label)
    }
}
