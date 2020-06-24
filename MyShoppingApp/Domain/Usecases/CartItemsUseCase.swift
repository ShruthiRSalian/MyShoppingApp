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

protocol CartItemsUseCase {
    var items: BehaviorRelay<[Item]> { get }
    func add(item: Item)
    func remove(itemId: Int)
    func reset()
    var totalCost: Float { get }
    var itemCountString: String { get }
}

class DefaultCartItemsUseCase: CartItemsUseCase {
    var items: BehaviorRelay<[Item]> = BehaviorRelay.init(value: [])
    
    func add(item: Item) {
        var newValue = items.value
        newValue = newValue + [item]
        items.accept(newValue)
    }
    
    //Remove item with id
    func remove(itemId: Int) {
        var newValue = items.value
        newValue = newValue.filter {$0.id != itemId}
        items.accept(newValue)
    }
    
    //Assign empty array using accept, as this change has to be notified.
    func reset() {
        items.accept([])
    }
    
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
            return ""
        }
        
        return "(\(items.value.count) items)"
    }
}
