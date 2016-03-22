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

typealias CompletionHandler = ((error:String?)->Void)?

class DoorsInteractor {
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init(){}
    
    /**
     Retrieve the doors in case is a detail call with a building given.
     
     - parameter build:      valid building
     - parameter completion: completion description (data = [Door], error = error description)
     */
    func getDoorsByBuilding(build:Building,completion:FetchCompletionHandler){
        let fetchRequest       = NSFetchRequest(entityName: "Door")
        fetchRequest.predicate = NSPredicate(format: "building == %@", build)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [Door]
            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    /**
     Retrieve all the doors created. TODO: Retrieve just the permited by the current user.
     
     - parameter completion: completion description (data = [Door], error = error description)
     */
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
    
    /**
     Retrieve all granted users for a given door.
     
     - parameter door:       valid door data type.
     - parameter completion: completion description (data = [Permision], error = error description)
     */
    func getPermissionsByDoor(door:Door,completion:FetchCompletionHandler){
        let fetchRequest       = NSFetchRequest(entityName: "Permision")
        fetchRequest.predicate = NSPredicate(format: "door == %@", door)
        do{
            let fetchResults  = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding = fetchResults.finalResult as! [Permision]

            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    /**
     Grant access to a user with username = @name.
     
     - parameter name:       username, not empty.
     - parameter door:       door to be permited.
     - parameter completion: completion description (error == nil => Everything ok, error != nil => Error description)
     */
    func givePermission(name:String, door:Door, completion:CompletionHandler){
        let fetchRequest       = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userUsername = %@", name)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchUser    = fetchResults.finalResult as! [User]
            
            if fetchUser.count > 0 {
                let permission  = NSEntityDescription.insertNewObjectForEntityForName("Permision", inManagedObjectContext: managedObjectContext) as! Permision
                permission.door = door
                permission.user = fetchUser.first!
                permission.date = NSDate()
                
                try managedObjectContext.save()
                
                completion!(error: nil)
            }else{
                completion!(error: "User doesn't exist")
            }
        }catch{
            completion!(error: "CoreData error")
        }
    }
    
    /**
     Delete given door from db.
     
     - parameter door: active and valid Door.
     */
    func deleteDoor(door:Door){
        if UserService.sharedInstance.currentUser! == door.building?.owner{
            managedObjectContext.deleteObject(door)
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error deleting Door")
            }
        }else{
            //Not yet implemented in UI
            print("That's not your door")
        }
    }
    
    /**
     Add a new door to a given Building
     
     - parameter building: Valid Building owned by current user
     - parameter name:     Valid String not empty
     - parameter avatar:   Avatar index (0-4)
    */
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
        permission.date = NSDate()

        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Door")
        }
    }
    
    /**
     Check if a given user has permission to open an specific door
     
     - parameter user:       Valid user added to the DB
     - parameter door:       valid door added to the DB
     - parameter completion: completion description (error == nil => Everything ok, error != nil => Error description)
     */
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