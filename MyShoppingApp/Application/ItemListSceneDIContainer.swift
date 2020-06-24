//
//  ItemListSceneDIContainer.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Firebase

final class ItemListSceneDIContainer {

    struct Dependencies {
        let itemListRepository: ItemListRepository
        let imageDownloadRepository: ImageDownloadRepository
    }

    private let dependencies: Dependencies
    private var cartUseCase: CartItemsUseCase
    
    init(dependencies: Dependencies, cartUseCase: CartItemsUseCase) {
        self.dependencies = dependencies
        self.cartUseCase = cartUseCase
    }
    
    // MARK: - Use Cases
    func itemListUseCase() -> ItemListUseCase {
        return DefaultItemListUseCase(itemListRepository: makeItemListRepository())
    }
    
    // MARK: - Repository
    func makeItemListRepository() -> ItemListRepository {
        return dependencies.itemListRepository
    }
    
    // MARK: - ItemList
    func makeItemListViewController(closures: ItemListViewModelClosures) -> ItemListViewController {
        return ItemListViewController.create(with: makeItemListViewModel(closures: closures), imageDownloadRepository: dependencies.imageDownloadRepository)
    }
    
    func makeItemListViewModel(closures: ItemListViewModelClosures) -> ItemListViewModel {
        return DefaultItemListViewModel(itemListUseCase: itemListUseCase(), cartItemUseCase: cartUseCase, closure: closures)
    }
    
    // MARK: - MyCart
    func makeMyCartViewController(cartUseCase: CartItemsUseCase, closures: MyCartViewModelClosures) -> MyCartViewController {
        return MyCartViewController.create(with: makeMyCartViewModel(cartUseCase: cartUseCase, closures: closures), imageDownloadRepository: dependencies.imageDownloadRepository)
    }
    
    func makeMyCartViewModel(cartUseCase: CartItemsUseCase, closures: MyCartViewModelClosures) -> MyCartViewModel {
        return DefaultMyCartViewModel(cartItemUseCase: cartUseCase, closures: closures)
    }
    
    // MARK: - Checkout
    func makeCheckoutViewController(cartUseCase: CartItemsUseCase, closures: CheckoutViewModelClosures) -> CheckoutViewController {
        return CheckoutViewController.create(with: makeCheckoutViewModel(cartUseCase: cartUseCase, closures: closures))
    }
    
    func makeCheckoutViewModel(cartUseCase: CartItemsUseCase, closures: CheckoutViewModelClosures) -> CheckoutViewModel {
        return DefaultCheckoutViewModel(cartItemUseCase: cartUseCase, closures: closures)
    }
    
    // MARK: - Result
    func makeResultViewController(cartUseCase: CartItemsUseCase, closures: ResultViewModelClosures) -> ResultViewController {
        return ResultViewController.create(with: makeResultViewModel(cartUseCase: cartUseCase, closures: closures))
    }
    
    func makeResultViewModel(cartUseCase: CartItemsUseCase, closures: ResultViewModelClosures) -> ResultViewModel {
        return DefaultResultViewModel(cartItemUseCase: cartUseCase, closures: closures)
    }
    
    // MARK: - Flow Coordinators
    func makeItemListFlowCoordinator(navigationController: UINavigationController) -> ItemListFlowCoordinator {
        return ItemListFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

protocol ItemListFlowCoordinatorDependencies  {
    func makeItemListViewController(closures: ItemListViewModelClosures) -> ItemListViewController
    func makeMyCartViewController(cartUseCase: CartItemsUseCase, closures: MyCartViewModelClosures) -> MyCartViewController
    func makeCheckoutViewController(cartUseCase: CartItemsUseCase, closures: CheckoutViewModelClosures) -> CheckoutViewController
    func makeResultViewController(cartUseCase: CartItemsUseCase, closures: ResultViewModelClosures) -> ResultViewController
}

extension ItemListSceneDIContainer: ItemListFlowCoordinatorDependencies {}

