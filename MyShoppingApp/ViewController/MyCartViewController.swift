//
//  MyCartViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 17/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController {
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        items = CartItems.shared.getItems()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartItems.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCartTableViewCell") as? MyCartTableViewCell {
            cell.nameLabel.text = items[indexPath.row].name
            cell.descriptionLabel.text = items[indexPath.row].description
            cell.itemImageView.downloaded(from: items[indexPath.row].imageUrl ?? "")
            return cell
        }
        return UITableViewCell()
    }
}
