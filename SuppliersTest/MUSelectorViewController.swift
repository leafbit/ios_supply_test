//
//  MUSelectorViewController.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/20/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit

class MUSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseUnit(sender: UIButton) {
    
        let dict = ["mu": sender.titleLabel!.text as! AnyObject]
        NSNotificationCenter.defaultCenter().postNotificationName("editProductMUChange", object: dict)
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(false, completion: nil)
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
