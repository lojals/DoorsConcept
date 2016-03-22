//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var userAvatar: String?
    @NSManaged var userPassword: String?
    @NSManaged var userUsername: String?
    @NSManaged var buildings: NSSet?
    @NSManaged var history: NSSet?
    @NSManaged var premission: NSSet?

}
