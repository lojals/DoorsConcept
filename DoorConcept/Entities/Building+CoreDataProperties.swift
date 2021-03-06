//
//  Building+CoreDataProperties.swift
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

extension Building {

    @NSManaged var buildingAvatar: String?
    @NSManaged var buildingCreatedAt: NSDate?
    @NSManaged var buildingName: String?
    @NSManaged var doors: NSSet?
    @NSManaged var owner: User?

}
