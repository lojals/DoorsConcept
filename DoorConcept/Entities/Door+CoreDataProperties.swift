//
//  Door+CoreDataProperties.swift
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

extension Door {

    @NSManaged var doorAvatar: String?
    @NSManaged var doorCreatedAt: NSDate?
    @NSManaged var doorName: String?
    @NSManaged var doorState: String?
    @NSManaged var building: Building?
    @NSManaged var history: NSSet?
    @NSManaged var permission: NSSet?

}
