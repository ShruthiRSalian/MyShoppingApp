//
//  ItemListRepository.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

protocol ItemListRepository {
    typealias CompletionHandler = (Result<[Item], Error>) -> Void
    
    func getItems(completion: @escaping (CompletionHandler))
}
