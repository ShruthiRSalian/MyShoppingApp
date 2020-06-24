//
//  ItemListViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol ItemListViewModelClosures {
    func showCart(cartUseCase: CartItemsUseCase) -> Void
}

protocol ItemListViewModelInput {
    func viewDidLoad()
    func didAddItem(viewModel: ItemViewModel)
    func cartButtonTap()
}

protocol ItemListViewModelOutput {
    var items: BehaviorRelay<[ItemViewModel]> { get }
    var disposeBag: DisposeBag { get }
    var cartItemUseCase: CartItemsUseCase { get }
    func getGoToCartString() -> String
}

protocol ItemListViewModel: ItemListViewModelInput, ItemListViewModelOutput {}

class DefaultItemListViewModel: ItemListViewModel {
    
    private let itemListUseCase: ItemListUseCase
    private let closures: ItemListViewModelClosures
    internal let cartItemUseCase: CartItemsUseCase
        
    // MARK: - Init
    init(itemListUseCase: ItemListUseCase, cartItemUseCase: CartItemsUseCase, closure: ItemListViewModelClosures) {
        self.itemListUseCase = itemListUseCase
        self.cartItemUseCase = cartItemUseCase
        self.closures = closure
    }
    
    // MARK: - Input
    func viewDidLoad() {
        loadItems()
        
    }

    func cartButtonTap() {
        closures.showCart(cartUseCase: cartItemUseCase)
    }
    
    func didAddItem(viewModel: ItemViewModel) {
        if let item = (listItems.filter{$0.id == viewModel.id}).first {
            cartItemUseCase.add(item: item)
        }
    }
    
    // MARK: - Output
    var items: BehaviorRelay<[ItemViewModel]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    func getGoToCartString() -> String {
        return "Goto Cart" + cartItemUseCase.itemCountString
    }
    
    // MARK: Private
    private var listItems = [Item]()
    
    private func assignItems(items: [Item]) {
        listItems = items
        let listItems = items.map(ItemViewModel.init)
        self.items.accept( listItems)
    }

    private func loadItems() {
        itemListUseCase.getItems { [weak self] result in
            switch result {
            case .failure(_):
                print("error")
            case .success(let data):
                self?.assignItems(items: data)
            }
        }
    }
}
