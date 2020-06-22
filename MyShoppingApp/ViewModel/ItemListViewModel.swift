//
//  ItemListViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class ItemListViewModel {
    
    var items: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
    var webServices: Networking?
    let disposeBag = DisposeBag()

    func getItems() {
        webServices?.getItems { [weak self] result in
            
            switch result {
            case .failure(_):
                print("error")
            case .success(let data):
                self?.items.accept( data)
            }
        }
    }
}

// MARK: ItemListDelegate.
extension ItemListViewModel: ItemListDelegate {
    //create new array using old items and new item to add. Assign this value using accept, as this change has to be notified.
    func itemAddedToCart(at index: Int) {
        let newValue = CartItems.shared.items.value + [items.value[index]]
        CartItems.shared.items.accept(newValue)
    }
}
