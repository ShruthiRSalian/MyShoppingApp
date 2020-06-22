//
//  WebAPIs.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Firebase

protocol Networking {
  typealias CompletionHandler = (Result<[Item], Error>) -> Void
  
  func getItems(completion: @escaping (CompletionHandler))
}

class WebServices: Networking {
    
    let db = Firestore.firestore()
    
    //Confirming to Networking protocol
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
            let item = Item(name: document.data()["name"] as? String, imageUrl: document.data()["imageUrl"] as? String, description: document.data()["description"] as? String, price: document.data()["price"] as? Float)
            items.append(item)
        }
        return items
    }
}
