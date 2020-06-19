//
//  WebAPIs.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Firebase

enum ApiError: Error {
    case unableToFetch
}

protocol Networking {
  typealias CompletionHandler = (Result<[Item], Error>) -> Void
  
  func getItems(completion: @escaping (CompletionHandler))
}

class WebServices: Networking {
    
    let db = Firestore.firestore()
    
    func getItems(completion: @escaping (CompletionHandler)) {
        db.collection("items").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print(err)
                completion(.failure(err))
            } else {
                let items = self.parseItemList(documents: querySnapshot!.documents) ?? []
                completion(.success(items))
            }
        }
    }
    
    func parseItemList(documents: [QueryDocumentSnapshot]) -> [Item] {
        var items = [Item]()
        for document in documents {
            let item = Item(name: document.data()["name"] as? String, imageUrl: document.data()["imageUrl"] as? String, description: document.data()["description"] as? String)
            items.append(item)
        }
        return items
    }
}

class MocResponse: Networking {
    func getItems(completion: @escaping (CompletionHandler)) {
        var items = [Item]()
        let item1 = Item(name: "test", imageUrl: "https://natgeo.imgix.net/factsheets/thumbnails/01-balance-of-nature.adapt.jpg?auto=compress,format&w=1600&h=900&fit=crop", description: "test description")
        let item2 = Item(name: "test2", imageUrl: "https://natgeo.imgix.net/factsheets/thumbnails/01-balance-of-nature.adapt.jpg?auto=compress,format&w=1600&h=900&fit=crop", description: "test description")
        items.append(item1)
        items.append(item2)
        completion(.success(items))
    }
}
