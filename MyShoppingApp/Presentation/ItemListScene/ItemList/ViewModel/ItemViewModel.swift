//
//  ItemViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

struct ItemViewModel: Equatable {
    var id: Int
    var name: String
    var imageUrl: String?
    var itemPrice: String
}

extension ItemViewModel {
    init(item: Item ) {
        self.id = item.id
        self.name = item.name ?? ""
        self.imageUrl = item.imageUrl
        self.itemPrice = "$ \(item.price ?? 0)"
    }
}
