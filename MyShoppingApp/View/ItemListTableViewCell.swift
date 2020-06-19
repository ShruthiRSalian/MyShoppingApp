//
//  ItemListTableViewCell.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit


protocol ItemListDelegate : class {
    func itemAddedToCart(at index: Int)
}

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var index: Int = 0
    weak var delegate: ItemListDelegate?
    
    @IBAction func addToCart(sender: UIButton) {
        delegate?.itemAddedToCart(at: index)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
