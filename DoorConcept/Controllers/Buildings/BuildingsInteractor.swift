//
//  BuildingsInteractor.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/21/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import CoreData

typealias FetchCompletionHandler = ((data:[AnyObject]?,error:String?)->Void)?

class BuildingsInteractor {
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init(){}
    
    /**
     Retrieve all the buildings created. TODO: Retrieve just the permited by the current user.
     
     - parameter completion: completion description (data = [Building], error = error description)
     */
    func getBuildings(completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "Building")
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [Building]
            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    /**
     Add a new Building
     
     - parameter user:   user adding the Building
     - parameter name:   Building name
     - parameter avatar: Avatar image name index (0-4) (building_[index].png)
     */
    func saveBuilding(user:User, name:String, avatar:String){
        let build1               = NSEntityDescription.insertNewObjectForEntityForName("Building", inManagedObjectContext: managedObjectContext) as! Building
        build1.owner             = user
        build1.buildingName      = name
        build1.buildingAvatar    = avatar
        build1.buildingCreatedAt = NSDate()
        
        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Building")
        }
    }
    
    /**
     Delete building from the db
     
     - parameter building: valid building
     */
    func deleteBuilding(building:Building){
        if UserService.sharedInstance.currentUser! == building.owner!{
            managedObjectContext.deleteObject(building)
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error deleting Door")
            }
        }else{
            //Not yet implemented un UI
            print("That's not your building")
        }
    }
}
