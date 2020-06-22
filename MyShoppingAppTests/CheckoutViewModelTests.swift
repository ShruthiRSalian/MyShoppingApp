//
//  CheckoutViewModelTests.swift
//  MyShoppingAppTests
//
//  Created by Shruthi Salian on 20/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import XCTest
import Swinject

@testable import MyShoppingApp

class CheckoutViewModelTests: XCTestCase {
    
    var container = Container()
    var checkoutVM = CheckoutViewModel()

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }

    func testValidateCardText() {
        var value = checkoutVM.validate(cardText: "1111 1111 1111")
        XCTAssertTrue(value)
        value = checkoutVM.validate(cardText: "1111 1111")
        XCTAssertFalse(value)
    }
    
    func testValidateExpDate() {
        var value = checkoutVM.validate(expirationDateText: "11/2020")
        XCTAssertTrue(value)
        value = checkoutVM.validate(expirationDateText: "40/1111")
        XCTAssertFalse(value)
    }
    
    func testValidateCVV() {
        var value = checkoutVM.validate(cvvText: "111")
        XCTAssertTrue(value)
        value = checkoutVM.validate(cardText: "aaa")
        XCTAssertFalse(value)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
