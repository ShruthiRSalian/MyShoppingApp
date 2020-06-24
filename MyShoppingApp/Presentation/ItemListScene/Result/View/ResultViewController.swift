//
//  ResultViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var resultViewModel: ResultViewModel!
    
    static func create(with viewModel: ResultViewModel) -> ResultViewController {
        let view = ResultViewController.instantiateViewController()
        view.resultViewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Called to update viewModel properties
        resultViewModel.viewDidLoad()
        self.quantityLabel.text = resultViewModel.itemCount
        self.priceLabel.text = resultViewModel.totalCost
    }
    
    //MARK: Navigation
    @IBAction func goToHomeAction(_ sender: Any) {
        resultViewModel.goToHome()
    }
}
