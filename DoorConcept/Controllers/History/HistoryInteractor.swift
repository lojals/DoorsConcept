//
//  HistoryInteractor.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/22/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import CoreData


class HistoryInteractor {
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init(){}
    
    /**
     Method to retrieve History for a User, check wether the current user owns the Building or not.
     
     - parameter completion: completion description (data = [History], error = error description)
     */
    func getHistory(completion:FetchCompletionHandler){
        let fetchRequest = NSFetchRequest(entityName: "History")
        fetchRequest.predicate = NSPredicate(format: "user == %@ OR door.building IN %@", UserService.sharedInstance.currentUser!, UserService.sharedInstance.currentUser!.buildings!)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchBuilding    = fetchResults.finalResult as! [History]
            completion!(data:fetchBuilding, error: nil)
        }catch{
            completion!(data:nil,error: "CoreData error!")
        }
    }
    
    /**
     Method to save History on CoreData, from user/door. An user attempt to open a door
     
     - parameter door:  Door datatype to be added to the History
     - parameter user:  User datatype to be added to the History
     - parameter state: Transaction's state, passible (authorized/denied)
     */
    func saveHistory(door:Door, user:User, state:String){
        let history = NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: managedObjectContext) as! History
        history.door  = door
        history.user  = user
        history.state = state
        history.date  = NSDate()
        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Door")
        }
    }
}
