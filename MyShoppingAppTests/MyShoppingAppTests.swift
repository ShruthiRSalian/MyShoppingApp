//
//  MyShoppingAppTests.swift
//  MyShoppingAppTests
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import XCTest
import Swinject
@testable import MyShoppingApp

class MyShoppingAppTests: XCTestCase {
    
    var container = Container()
    var itemListVC = ItemListViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        container.register(Networking.self) { _ in
            MocResponse()
        }
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let response = container.resolve(Networking.self)!
        itemListVC.getItems(webServices: response)
        XCTAssertEqual(itemListVC.items.first?.name, "test")
        //XCTAssertEqual(response.data, "999456")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
