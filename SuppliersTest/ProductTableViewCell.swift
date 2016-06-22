//
//  ProductTableViewCell.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/20/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    var product: Product? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var more: UILabel!
    
    func updateUI() {
        img?.image = nil
        name?.text = nil
        price?.text = nil
        more?.text = nil
        
        if let p = product {
            p.managedObjectContext?.performBlock({
                self.name?.text = p.name
                self.price?.text = p.supplyPrice?.stringValue
                self.more?.text = p.details
            })
        }
        
    }
}
