//
//  ItemListTableViewCell.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    private var viewModel: ItemViewModel!
    private var imageDownloadRepository: ImageDownloadRepository?
    
    //Closure to add item
    var addItem: ((ItemViewModel) -> Void)?
    
    @IBAction func addToCart(sender: UIButton) {
        addItem?(viewModel)
    }
    
    func configureWith(itemViewModel: ItemViewModel, imageDownloadRepository: ImageDownloadRepository?) {
        self.viewModel = itemViewModel
        self.imageDownloadRepository = imageDownloadRepository
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.itemPrice
        updateImage()
    }
    
    private func updateImage() {
        itemImageView.image = nil
        guard let imageUrl = viewModel.imageUrl else { return }
        
        imageDownloadRepository?.fetchImage(with: imageUrl) { [weak self] result in
            guard let self = self else { return }
            guard self.viewModel.imageUrl == imageUrl else { return }
            if case let .success(data) = result {
                if (data != nil) {
                    self.itemImageView.image = UIImage(data: data!)
                }
                
            }
        }
    }
}
