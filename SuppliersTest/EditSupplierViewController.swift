//
//  EditSupplierViewController.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/19/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import UIKit
import CoreData

class EditSupplierViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textAddress: UITextField!
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // MARK: Model
    
    @IBAction func Save(sender: AnyObject) {
        
        managedContext.performBlock({
            if let company = NSEntityDescription.insertNewObjectForEntityForName("Supplier",
                inManagedObjectContext: self.managedContext) as? Supplier{
                company.name = self.textName.stringValue
                company.address = self.textAddress.stringValue
            }
            do {
                try self.managedContext.save()
                //5
                //people.append(person)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        })
    }

    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("updateSuppliers", object: nil)
    }
    
    // MARK: Take Photos
    
    let picker = UIImagePickerController()
    
    @IBAction func TakeNameCardPhoto() {
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
            picker.allowsEditing = false
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: {})
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        if let pickedImage: UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            let selectorToCall = #selector(EditSupplierViewController.imageWasSavedSuccessfully(_:didFinishSavingWithError:context:))
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, selectorToCall, nil)
        }
        picker.dismissViewControllerAnimated(true, completion: {
            // Anything to happend when user saves the image
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything to happend when user cancels camera
        })
    }
    
    func imageWasSavedSuccessfully(image: UIImage, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>){
        print("Image saved")
        if let theError = error {
            print("An error occured while saving the image \(theError)")
        } else {
            print("Displaying")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // put the image on screen
                //self.currentImage.image = image
            })
        }
    }
    
    // MARK: Helpers
    
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
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
