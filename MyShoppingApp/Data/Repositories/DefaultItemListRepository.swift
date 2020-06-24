//
//  DefaultItemListRepository.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Firebase

public final class DefaultItemListRepository {
    
    private let db: Firestore
    
    public init(with dataBase: Firestore) {
        self.db = dataBase
    }
}

//MARK: ItemListRepository
extension DefaultItemListRepository: ItemListRepository {
    func getItems(completion: @escaping (CompletionHandler)) {
        db.collection("items").getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                let items = self.parseItemList(documents: querySnapshot!.documents)
                completion(.success(items))
            }
        }
    }
    
    func parseItemList(documents: [QueryDocumentSnapshot]) -> [Item] {
        var items = [Item]()
        for document in documents {
            let item = Item(id: document.data()["id"] as! Int, name: document.data()["name"] as? String, imageUrl: document.data()["imageUrl"] as? String, description: document.data()["description"] as? String, price: document.data()["price"] as? Float)
            items.append(item)
        }
        return items
    }
}
