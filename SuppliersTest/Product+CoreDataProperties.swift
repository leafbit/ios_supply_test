//
//  Product+CoreDataProperties.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/20/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var name: String?
    @NSManaged var itemNumber: String?
    @NSManaged var supplyPrice: NSNumber?
    @NSManaged var details: String?
    @NSManaged var supplier: Supplier?

}
