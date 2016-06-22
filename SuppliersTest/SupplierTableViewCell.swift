//
//  SupplierTableViewCell.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/19/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit

class SupplierTableViewCell: UITableViewCell {

    var supplier: Supplier? {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    func updateUI(){
        
        // Reset existring:
        
        img?.image = nil
        labelName?.text = nil
        labelAddress?.text = nil
        
        if let s = self.supplier{
            s.managedObjectContext?.performBlockAndWait({
                self.labelName?.text = s.name
                self.labelAddress?.text = s.address
                if let path = s.nameCard {
                    if let imageData = NSData(contentsOfFile: path) {
                        self.img?.image = UIImage(data: imageData)
                    }
                }
            })
        }
        
    }

}
