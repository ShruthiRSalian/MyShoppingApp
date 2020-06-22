//
//  CartItems.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 18/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class CartItems {
    static let shared = CartItems()
    var items: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
}

// MARK: Computed properties
extension CartItems {
    
    //Since items is BehaviorRelay type access it using value
    var totalCost: Float {
        let value = items.value.reduce(0) { (currentTotal, item) in
            return currentTotal + (item.price ?? 0)
        }
        return value
    }
    
    //Since items is BehaviorRelay type access it using value
    var itemCountString: String {
        guard items.value.count > 0 else {
            return "0 item"
        }
        
        return "\(items.value.count) items"
    }
}
