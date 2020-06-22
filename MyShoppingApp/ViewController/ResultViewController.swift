//
//  ResultViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.quantityLabel.text = CartItems.shared.itemCountString
        self.priceLabel.text = "$ \(CartItems.shared.totalCost)"
    }
    
    @IBAction func goToHomeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
