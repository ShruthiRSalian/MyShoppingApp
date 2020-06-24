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

class MyCartViewController: UIViewController, StoryboardInstantiable {
    
    private var mycartViewModel: MyCartViewModel!
    private var imageDownloadRepository: ImageDownloadRepository?
    
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var myCartTableView: UITableView!
    
    static func create(with viewModel: MyCartViewModel,
                       imageDownloadRepository: ImageDownloadRepository?) -> MyCartViewController {
        let view = MyCartViewController.instantiateViewController()
        view.mycartViewModel = viewModel
        view.imageDownloadRepository = imageDownloadRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mycartViewModel.viewDidLoad()
        setUpObserver()
        setUpCellConfig()
    }
    
    //Setting up observer to update checkout and reset button state. Value is taken from cart item count
    func setUpObserver() {
        mycartViewModel.items.asObservable()
            .subscribe(onNext: {
                [unowned self] item in
                self.checkOutButton.isEnabled = item.count > 0 ? true : false
                self.resetButton.isEnabled = item.count > 0 ? true : false
            })
            .disposed(by: mycartViewModel.disposeBag)
    }
    
    // Populates tableview with items. Done using Rx instance. NO need of delegates
    func setUpCellConfig() {
        mycartViewModel.items.bind(to: myCartTableView
            .rx.items(cellIdentifier: "myCartTableViewCell",
                      cellType: MyCartTableViewCell.self)) {
                        row, item, cell in
                        cell.removeItem = { [weak self] viewModel in
                            self?.mycartViewModel.didRemoveItem(viewModel: viewModel)
                        }
                        cell.configureWith(itemViewModel: item, imageDownloadRepository: self.imageDownloadRepository)
        }.disposed(by: mycartViewModel.disposeBag)
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        mycartViewModel.checkOut()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        mycartViewModel.reset()
    }
}
