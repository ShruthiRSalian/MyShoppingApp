//
//  CartItems.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 18/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

class CartItems {
    static var shared = CartItems()
    
    var items = Set<Item>()
    
    func getItems() -> [Item] {
        return Array(items)
    }
    
    private init() {
        
    }
    
    
}
