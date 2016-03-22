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
    
    func saveHistory(door:Door, user:User, state:String){
        let history = NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: managedObjectContext) as! History
        history.door  = door
        history.user  = user
        history.state = state
        history.date  = NSDate()
        
        print(history.date)
        
        do{
            try managedObjectContext.save()
        }catch{
            print("Some error inserting Door")
        }
    }
    
}
