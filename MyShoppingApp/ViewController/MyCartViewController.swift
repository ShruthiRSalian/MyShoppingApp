//
//  MyCartViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class MyCartViewController: UIViewController {
    
    var mycartViewModel = MyCartViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var myCartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpObserver()
        setUpCellConfig()
    }
    
    //Setting up observer to update checkout and reset button state. Value is taken from cart item count
    func setUpObserver() {
        CartItems.shared.items.asObservable()
            .subscribe(onNext: {
                [unowned self] item in
                self.checkOutButton.isEnabled = item.count > 0 ? true : false
                self.resetButton.isEnabled = item.count > 0 ? true : false
            })
        .disposed(by: disposeBag)
    }
    
    // Populates tableview with items. Done using Rx instance. NO need of delegates
    func setUpCellConfig() {
        CartItems.shared.items.bind(to: myCartTableView
            .rx.items(cellIdentifier: "myCartTableViewCell",
                      cellType: MyCartTableViewCell.self)) {
                        row, item, cell in
                        cell.index = row
                        cell.delegate = self.mycartViewModel
                        cell.configureWithItem(item: item)
        }.disposed(by: disposeBag)
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "checkoutViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        mycartViewModel.reset()
    }
}
