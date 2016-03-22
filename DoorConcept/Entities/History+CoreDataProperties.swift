//
//  History+CoreDataProperties.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/22/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension History {

    @NSManaged var date: NSDate?
    @NSManaged var state: String?
    @NSManaged var door: Door?
    @NSManaged var user: User?

}
