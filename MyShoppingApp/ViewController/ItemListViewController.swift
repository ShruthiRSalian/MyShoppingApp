//
//  ViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    var items = [Item]()
    var webServices: Networking?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.target = self
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.action = #selector(cartButtonTapped)
                
        //guard let webServices = webServices else { fatalError("Missing dependencies") }
        getItems()
        
    }
    
    func getItems() {
        webServices?.getItems { [weak self] result in
            
            switch result {
            case .failure(_):
                print("error")
            case .success(let data):
                self?.items = data
            }
            self?.tableView?.reloadData()
        }
    }
    
    @objc func cartButtonTapped() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MyCartViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ItemListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemListTableViewCell") as? ItemListTableViewCell {
            cell.nameLabel.text = items[indexPath.row].name
            cell.descriptionLabel.text = items[indexPath.row].description
            cell.itemImageView.downloaded(from: items[indexPath.row].imageUrl ?? "")
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension ItemListViewController: ItemListDelegate {
    func itemAddedToCart(at index: Int) {
        CartItems.shared.items.insert(items[index])
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.title = CartItems.shared.items.count > 0 ? "\(CartItems.shared.items.count) items" : "0 item"
    }
}

