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

enum DoorTransacStatus:String{
    case Authorized = "Authorized"
    case Denied     = "Access Denied!"
    case Ready      = "Ready!"
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
    
    func getPermissionsByDoor(door:Door,completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "Permision")
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [Permision]
            fetchRequest.predicate = NSPredicate(format: "door == %@", door)
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
        
        
        let permission = NSEntityDescription.insertNewObjectForEntityForName("Permision", inManagedObjectContext: managedObjectContext) as! Permision
        permission.door = door
        permission.user = building.owner

        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Door")
        }
    }
    
    func checkPermission(user:User,door:Door,completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "Permision")
        fetchRequest.predicate = NSPredicate(format: "user == %@ AND door == %@", user,door)
        do{
            let fetchResults   = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchPermision = fetchResults.finalResult as! [Door]
            if fetchPermision.count > 0 {
                completion!(data:fetchPermision, error: nil)
            }else{
                completion!(data:fetchPermision, error: "Doesn't have permission")
            }
            
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
}
