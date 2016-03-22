//
//  BuildingsInteractor.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/21/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import CoreData

enum DoorState:String{
    case Opened = "Opened"
    case Closed = "Closed"
}

class DoorsInteractor {
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init(){
    
    }
    
    func getDoorsByBuilding(build:Building,completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "Door")
        fetchRequest.predicate = NSPredicate(format: "building == %@", build)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [Door]
            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    func getDoors(completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "Door")
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [Door]
            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    func saveDoor(building:Building, name:String, avatar:String){
        let door           = NSEntityDescription.insertNewObjectForEntityForName("Door", inManagedObjectContext: managedObjectContext) as! Door
        door.doorName      = name
        door.doorState     = DoorState.Closed.rawValue
        door.doorAvatar    = avatar
        door.doorCreatedAt = NSDate()
        door.building      = building

        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Door")
        }
    }
    
}
