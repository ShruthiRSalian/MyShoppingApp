//
//  ItemListFlowCoordinator.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 24/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class ItemListFlowCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: ItemListFlowCoordinatorDependencies

    private weak var itemListVC: ItemListViewController?

    init(navigationController: UINavigationController,
         dependencies: ItemListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeItemListViewController(closures: self)
        navigationController.pushViewController(vc, animated: false)
        itemListVC = vc
    }
}

extension ItemListFlowCoordinator : ItemListViewModelClosures {
    func showCart(cartUseCase: CartItemsUseCase) {
        let vc = dependencies.makeMyCartViewController(cartUseCase: cartUseCase, closures: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ItemListFlowCoordinator : MyCartViewModelClosures {
    func showPaymentPage(cartUseCase: CartItemsUseCase) {
        let vc = dependencies.makeCheckoutViewController(cartUseCase: cartUseCase, closures: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ItemListFlowCoordinator : CheckoutViewModelClosures {
    func showResult(cartUseCase: CartItemsUseCase) {
        let vc = dependencies.makeResultViewController(cartUseCase: cartUseCase, closures: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ItemListFlowCoordinator: ResultViewModelClosures {
    func goToHome() {
        navigationController.popToRootViewController(animated: true)
    }
}
