//
//  AppFlowCoordinator.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let itemListSceneDIContainer = appDIContainer.makeItemListSceneDIContainer()
        let flow = itemListSceneDIContainer.makeItemListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
