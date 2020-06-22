//
//  ItemListViewModelTests.swift
//  MyShoppingAppTests
//
//  Created by Shruthi Salian on 20/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import XCTest
import Swinject

@testable import MyShoppingApp

//MocResponse class to moc the response of the web services.
class MocResponse: Networking {
    func getItems(completion: @escaping (CompletionHandler)) {
        var items = [Item]()
        let item1 = Item(name: "Audemars Piguet", imageUrl: "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Bell-Ross.jpg", description: "test description", price: 4.5)
        let item2 = Item(name: "Breguet", imageUrl: "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Breitling.jpg", description: "test description", price: 10)
        items.append(item1)
        items.append(item2)
        completion(.success(items))
    }
}

class ItemListViewModelTests: XCTestCase {
    
    var container = Container()
    var itemListVM = ItemListViewModel()

    override func setUp() {
        super.setUp()
        container.register(Networking.self) { _ in
            MocResponse()
        }
        container.register([Item].self) { test in
            let item1 = Item(name: "Lange & Söhne", imageUrl: "https://manofmany.com/wp-content/uploads/2017/06/32-Top-Luxury-Watch-Brands.jpg", price: 4.5)
            return [item1]
        }
        CartItems.shared.items.accept(container.resolve([Item].self) ?? [Item]())
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }

    func testgetItems() {
        let webservice = container.resolve(Networking.self)!
        itemListVM.webServices = webservice
        itemListVM.getItems()
        XCTAssertEqual(itemListVM.items.value.first?.name, "Audemars Piguet")
        XCTAssertEqual(itemListVM.items.value.first?.imageUrl, "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Bell-Ross.jpg")
        XCTAssertEqual(itemListVM.items.value.first?.description, "test description")
        XCTAssertEqual(itemListVM.items.value.first?.price, 4.5)
        
        XCTAssertEqual(itemListVM.items.value[1].name, "Breguet")
        XCTAssertEqual(itemListVM.items.value[1].imageUrl, "https://manofmany.com/wp-content/uploads/2017/06/Top-Luxury-Watch-Brands-Breitling.jpg")
        XCTAssertEqual(itemListVM.items.value[1].description, "test description")
        XCTAssertEqual(itemListVM.items.value[1].price, 10)
    }
    
    func testItemAddedToCart() {
        let webservice = container.resolve(Networking.self)!
        itemListVM.webServices = webservice
        itemListVM.getItems()
        
        XCTAssert(CartItems.shared.items.value.count == 1)
        itemListVM.itemAddedToCart(at: 0)
        XCTAssert(CartItems.shared.items.value.count == 2)
        XCTAssert(CartItems.shared.items.value[1].name == "Audemars Piguet")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
