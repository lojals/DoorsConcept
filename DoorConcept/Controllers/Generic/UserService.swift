//
//  LoginService.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/21/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias LoginCompletionHandler      = ((logged:Bool, error:String?)->Void)?
typealias RetrievingCompletionHandler = ((error:String?)->Void)?

class UserService {
    static let sharedInstance        = UserService() // Singleton for a unique currentUser Instance
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var currentUser:User?            = nil
    
    /**
     Fill the userDefaul with the Username session
     
     - parameter username:          Username's user
     - parameter password:          Password's user
     - parameter completionHandler: Completion Handle for errors
     */
    func Login(username:String,password:String,completionHandler:LoginCompletionHandler){
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userUsername == %@ AND userPassword == %@", username, password)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchUser    = fetchResults.finalResult as! [User]
            if fetchUser.count > 0 {
                currentUser = (fetchUser.first! as User)
                NSUserDefaults.standardUserDefaults().setValue(self.currentUser!.userUsername!, forKey: "UserSession")
                NSUserDefaults.standardUserDefaults().setValue(NSDate(), forKey: "lastLogin")
                completionHandler!(logged: true,error: nil)
            }else{
                completionHandler!(logged: false,error: "Wrong credentials!")
            }
        }catch{
            completionHandler!(logged: false,error: "CoreData error!")
        }
    }
    
    /**
     Instance the User Session retrieving the User default
     
     - parameter completion: completion block to handle the possible errors
     */
    
    func retrieveSession(completion:RetrievingCompletionHandler){
        let session = NSUserDefaults.standardUserDefaults().stringForKey("UserSession")
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userUsername == %@", session!)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchUser    = fetchResults.finalResult as! [User]
            if fetchUser.count > 0 {
                self.currentUser = fetchUser[0]
                completion!(error: nil)
            }else{
                completion!(error: "Session expired!")
            }
        }catch{
            completion!(error: "CoreData error!")
        }
    }
    
    /**
     Get whether session is active or not, any moment
     
     - returns: Session Active
     */
    func checkSession()->Bool{
        let session = NSUserDefaults.standardUserDefaults().stringForKey("UserSession")
        if(session != nil){
            return true
        }else{
            return false
        }
    }
    
    /**
     Cleans the UserDefaults Session
     */
    func Logout(){
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "UserSession")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "lastLogin")
        self.currentUser = nil
        print("Logged out")
    }
    
    /**
     Retrieve last Session date
     
     - returns: Last login Date
     */
    func lastLogin()->NSDate{
        let date = NSUserDefaults.standardUserDefaults().valueForKey("lastLogin") as! NSDate
        return date
    }
    
    /**
     Intinialize users on CoreData db
     */
    func initializeData(){
        if !NSUserDefaults.standardUserDefaults().boolForKey("dataInitialized") {
            print("Initializing data...")
            
            let user1 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user1.userUsername = "Test.1"
            user1.userPassword = "123456"
            user1.userAvatar   = "0"
            
            let user2 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user2.userUsername = "Test.2"
            user2.userPassword = "123456"
            user2.userAvatar   = "2"
            
            let user3 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user3.userUsername = "Test.3"
            user3.userPassword = "123456"
            user3.userAvatar   = "7"
            
            let user4 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user4.userUsername = "Test.4"
            user4.userPassword = "123456"
            user4.userAvatar   = "9"
            
            let user5 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user5.userUsername = "J.Ovalle"
            user5.userPassword = "123456"
            user5.userAvatar   = "3"
            
            let user6 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user6.userUsername = "P.Beelen"
            user6.userPassword = "123456"
            user6.userAvatar   = "5"
            
            let user7 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user7.userUsername = "V.Tufis"
            user7.userPassword = "123456"
            user7.userAvatar   = "10"
            
            let user8 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user8.userUsername = "B.Klaver"
            user8.userPassword = "123456"
            user8.userAvatar   = "1"
            
            let user9 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
            user9.userUsername = "Test.6"
            user9.userPassword = "123456"
            user9.userAvatar   = "4"
            
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error inserting User")
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dataInitialized")
        }
    }
}