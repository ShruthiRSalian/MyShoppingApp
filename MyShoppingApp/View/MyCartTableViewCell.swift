//
//  MyCartTableViewCell.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

protocol MyCartListDelegate : class {
    func removeItemFromCart(at index: Int)
}

class MyCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var index: Int = 0
    weak var delegate: MyCartListDelegate?

    @IBAction func removeFromCart(sender: UIButton) {
        delegate?.removeItemFromCart(at: index)
    }
    
    func configureWithItem(item: Item) {
        nameLabel.text = item.name
        descriptionLabel.text = "$ \(item.price ?? 0)"
        itemImageView.downloaded(from: item.imageUrl ?? "")
    }
}
