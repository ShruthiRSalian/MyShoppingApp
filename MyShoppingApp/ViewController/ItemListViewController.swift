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

class ItemListViewController: UIViewController {
    
    var itemListViewModel = ItemListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.target = self
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.action = #selector(cartButtonTapped)
                        
        itemListViewModel.getItems()
        setUpObserver()
        setUpCellConfig()
    }
    
    //Setting up observer to update button label. Value is taken from cart item count
    func setUpObserver() {
        CartItems.shared.items.asObservable()
            .subscribe(onNext: {
                [unowned self] _ in
                self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.title = CartItems.shared.itemCountString
            })
        .disposed(by: itemListViewModel.disposeBag)
    }
    
    // Populates tableview with items. Done using Rx instance. NO need of delegates
    func setUpCellConfig() {
        itemListViewModel.items.bind(to: tableView
            .rx.items(cellIdentifier: "itemListTableViewCell",
                      cellType: ItemListTableViewCell.self)) {
                        row, item, cell in
                        cell.index = row
                        cell.delegate = self.itemListViewModel
                        cell.configureWithItem(item: item)
        }.disposed(by: itemListViewModel.disposeBag)
    }

    //Selector for tap on navigation bar button
    @objc func cartButtonTapped() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MyCartViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

