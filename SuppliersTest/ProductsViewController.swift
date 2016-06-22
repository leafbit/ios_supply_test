//
//  ProductsViewController.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/20/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit
import CoreData

class ProductsViewController: CoreDataTableViewController, UITextFieldDelegate {
    
    var searchText: String? { didSet { updateUI() } }
    var managedObjectContext: NSManagedObjectContext? { didSet{ updateUI() } }
    
    
    // MARK: Model
    func updateUI(){
        if let context = managedObjectContext {
            let request = NSFetchRequest(entityName: "Product")
            if let companyName = searchText {
                request.predicate = NSPredicate(format: "name contains[c] %@", companyName)
            }
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }
    
    func loadList(notification: NSNotification){
        //load data here
        managedObjectContext?.refreshAllObjects()
        self.updateUI()
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: #selector(SuppliersViewController.loadList(_:)), name:"updateProducts", object: nil)
    }

    
    private struct Storyboard{
        static let CellReuseIdentifier = "ProductCell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! ProductTableViewCell
        
        // Configure the cell...
        if let product = fetchedResultsController?.objectAtIndexPath(indexPath) as? Product {
            cell.product = product
        }
        
        return cell
    }

    
    
    // MARK: Search
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
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
