//
//  MyCartViewModelTests.swift
//  MyShoppingAppTests
//
//  Created by Shruthi Salian on 20/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import XCTest
import Swinject

@testable import MyShoppingApp

class MyCartViewModelTests: XCTestCase {
    
    var container = Container()
    var myCartVM = MyCartViewModel()

    override func setUp() {
        super.setUp()
        container.register([Item].self) { test in
            let item1 = Item(name: "Audemars Piguet", imageUrl: "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Bell-Ross.jpg", description: "test description", price: 4.5)
            let item2 = Item(name: "Audemars Piguet2", imageUrl: "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Bell-Ross.jpg", description: "test description", price: 10)
            return [item1, item2]
        }
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }

    func testReset() {
        CartItems.shared.items.accept(container.resolve([Item].self) ?? [Item]())
        XCTAssert(CartItems.shared.items.value.count == 2, "")
        myCartVM.reset()
        XCTAssert(CartItems.shared.items.value.count == 0, "")
    }
    
    func testRemoveItemFromCart() {
        CartItems.shared.items.accept(container.resolve([Item].self) ?? [Item]())
        XCTAssert(CartItems.shared.items.value.count == 2, "")
        myCartVM.removeItemFromCart(at: 0)
        XCTAssert(CartItems.shared.items.value.count == 1, "")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
