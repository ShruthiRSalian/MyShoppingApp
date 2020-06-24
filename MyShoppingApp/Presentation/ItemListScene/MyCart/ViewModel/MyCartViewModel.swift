//
//  MyCartViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol MyCartViewModelClosures {
    func showPaymentPage(cartUseCase: CartItemsUseCase) -> Void
}

protocol MyCartViewModelInput {
    func viewDidLoad()
    func didRemoveItem(viewModel: ItemViewModel)
    func reset()
    func checkOut()
}

protocol MyCartViewModelOutput {
    var items: BehaviorRelay<[ItemViewModel]> { get }
    var disposeBag: DisposeBag { get }
}

protocol MyCartViewModel: MyCartViewModelInput, MyCartViewModelOutput {}

class DefaultMyCartViewModel: MyCartViewModel {
    
    private let cartItemUseCase: CartItemsUseCase
    private let closures: MyCartViewModelClosures
    
    // MARK: - Init
    init(cartItemUseCase: CartItemsUseCase, closures: MyCartViewModelClosures) {
        self.cartItemUseCase = cartItemUseCase
        self.closures = closures
    }
    
    // MARK: - Output
    var items: BehaviorRelay<[ItemViewModel]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    
    // MARK: - Input
    func viewDidLoad() {
        
        cartItemUseCase.items.subscribe({
                [unowned self] _ in
            
            self.assignItems(items: self.cartItemUseCase.items.value)
            })
        .disposed(by: disposeBag)
    }
    
    func checkOut() {
        closures.showPaymentPage(cartUseCase: cartItemUseCase)
    }
    
    func didRemoveItem(viewModel: ItemViewModel) {
        cartItemUseCase.remove(itemId: viewModel.id)
    }
    
    func reset() {
        cartItemUseCase.reset()
    }
    
    // MARK: - Private
    private func assignItems(items: [Item]) {
        let listItems = items.map(ItemViewModel.init)
        self.items.accept( listItems)
    }
}
