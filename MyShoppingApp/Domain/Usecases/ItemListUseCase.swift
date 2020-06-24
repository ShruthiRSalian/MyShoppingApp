//
//  ItemListUseCase.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

protocol ItemListUseCase {
  typealias CompletionHandler = (Result<[Item], Error>) -> Void
  
  func getItems(completion: @escaping (CompletionHandler))
}

final class DefaultItemListUseCase: ItemListUseCase {
    
    private let itemListRepository: ItemListRepository
    
    init(itemListRepository: ItemListRepository) {
        self.itemListRepository = itemListRepository
    }
    
    func getItems(completion: @escaping (CompletionHandler)) {
        itemListRepository.getItems(completion: completion)
    }
}
