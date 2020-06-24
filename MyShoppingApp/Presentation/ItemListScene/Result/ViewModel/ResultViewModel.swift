//
//  ResultViewModel.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 24/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

protocol ResultViewModelClosures {
    func goToHome() -> Void
}

protocol ResultViewModelInput {
    func viewDidLoad()
    func goToHome()
}

protocol ResultViewModelOutput {
    var itemCount: String { get }
    var totalCost: String { get }
}

protocol ResultViewModel: ResultViewModelInput, ResultViewModelOutput {}

class DefaultResultViewModel: ResultViewModel {
    
    private let cartItemUseCase: CartItemsUseCase
    private let closures: ResultViewModelClosures
    
    // MARK: - Init
    init(cartItemUseCase: CartItemsUseCase, closures: ResultViewModelClosures) {
        self.cartItemUseCase = cartItemUseCase
        self.closures = closures
    }
    
    //MARK: - ResultViewModelInput
    func viewDidLoad() {
        totalCost = "$ \(cartItemUseCase.totalCost)"
        itemCount = cartItemUseCase.itemCountString
    }
    
    func goToHome() {
        closures.goToHome()
    }
    
    //MARK: - ResultViewModelOutput
    var totalCost: String = ""
    var itemCount: String = ""
}

