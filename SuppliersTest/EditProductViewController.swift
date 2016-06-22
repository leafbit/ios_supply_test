//
//  EditProductViewController.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/20/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit

class EditProductViewController: UIViewController {
    
    @IBOutlet weak var btnMU: UIButton!
    
    // MARK: View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Listen to measurement unit change message
        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(EditProductViewController.changeMU(_:)),name:"editProductMUChange", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeMU(notification: NSNotification) {
        if let dict = notification.object as? [String:AnyObject] {
            print("\(dict)")
            if let mu = dict["mu"] as? String{
                btnMU.setTitle(mu, forState: .Normal)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
