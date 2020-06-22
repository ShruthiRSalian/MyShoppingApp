//
//  MyCartViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

class MyCartViewModel {
    
    var enableCheckAndReset = CartItems.shared.items.value.count > 0 ? true : false
    
    //Assign empty array using accept, as this change has to be notified.
    func reset() {
        CartItems.shared.items.accept([])
    }
}

// MARK: MyCartListDelegate.
extension MyCartViewModel: MyCartListDelegate {
    //create new array using old items and remove specified item. Assign this value using accept, as this change has to be notified.
    func removeItemFromCart(at index: Int) {
        var newValue = CartItems.shared.items.value
        newValue.remove(at: index)
        CartItems.shared.items.accept(newValue)
    }
}
