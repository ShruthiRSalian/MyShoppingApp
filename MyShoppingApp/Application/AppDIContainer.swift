//
//  AppDIContainer.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Firebase

final class AppDIContainer {
        
    // MARK: - Network
    lazy var itemListRepository: ItemListRepository = {
        return DefaultItemListRepository(with: Firestore.firestore())
    }()
    lazy var imageDataTransferService: ImageDownloadRepository = {
        return DefaultImageDownloadRepository(networkService: DefaultNetworkService(sessionManager: DefaultNetworkSessionManager()))
    }()
    
    // MARK: - DIContainers of scenes
    func makeItemListSceneDIContainer() -> ItemListSceneDIContainer {
        let dependencies = ItemListSceneDIContainer.Dependencies(itemListRepository: itemListRepository, imageDownloadRepository: imageDataTransferService)
        return ItemListSceneDIContainer(dependencies: dependencies, cartUseCase: DefaultCartItemsUseCase())
    }
}

