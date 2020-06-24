//
//  ViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ItemListViewController: UIViewController, StoryboardInstantiable {
    
    private var itemListViewModel: ItemListViewModel!
    private var imageDownloadRepository: ImageDownloadRepository?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemButton: UIButton!
    
    static func create(with viewModel: ItemListViewModel,
                       imageDownloadRepository: ImageDownloadRepository?) -> ItemListViewController {
        let view = ItemListViewController.instantiateViewController()
        view.itemListViewModel = viewModel
        view.imageDownloadRepository = imageDownloadRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        itemListViewModel.viewDidLoad()
        setUpObserver()
        setUpCellConfig()
    }
    
    //Setting up observer to update button label. Value is taken from cart item count
    func setUpObserver() {
        itemListViewModel.cartItemUseCase.items.subscribe({
                [unowned self] _ in
            
            self.itemButton.setTitle(self.itemListViewModel.getGoToCartString(), for: .normal) 
            })
        .disposed(by: itemListViewModel.disposeBag)
    }
    
    // Populates tableview with items. Done using Rx instance. NO need of delegates
    func setUpCellConfig() {
        itemListViewModel.items.bind(to: tableView
            .rx.items(cellIdentifier: "itemListTableViewCell",
                      cellType: ItemListTableViewCell.self)) {
                        row, item, cell in
                        cell.addItem = { [weak self] viewModel in
                            self?.itemListViewModel.didAddItem(viewModel: viewModel)
                        }
                        cell.configureWith(itemViewModel: item, imageDownloadRepository: self.imageDownloadRepository)
        }.disposed(by: itemListViewModel.disposeBag)
    }

    @IBAction func cartButtonTapped(_ sender: Any) {
        itemListViewModel.cartButtonTap()
    }
}

