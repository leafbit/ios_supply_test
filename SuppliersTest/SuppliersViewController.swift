//
//  SuppliersViewController.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/19/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit
import CoreData

class SuppliersViewController: CoreDataTableViewController, UITextFieldDelegate {

    var searchText: String? { didSet { updateUI() } }
    var managedObjectContext: NSManagedObjectContext? { didSet{ updateUI() } }
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // var companies = [Supplier]()
    
    // Search field...
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To set the table cell to have an automatic height:
        // tableView.estimatedRowHeight = tableView.rowHeight
        // tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(SuppliersViewController.loadList(_:)),name:"updateSuppliers", object: nil)
    }
    
    func loadList(notification: NSNotification){
        //load data here
        managedObjectContext?.refreshAllObjects()
        self.updateUI()
    }
    
    private func updateUI(){
        if let context = managedObjectContext {
            let request = NSFetchRequest(entityName: "Supplier")
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
    
    private struct Storyboard{
        static let CellReuseIdentifier = "SupplierCell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! SupplierTableViewCell
        
        // Configure the cell...
        if let supplier = fetchedResultsController?.objectAtIndexPath(indexPath) as? Supplier {
            cell.supplier = supplier
        }
        
        return cell
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
