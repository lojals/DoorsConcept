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


class LoginService {
    static let sharedInstance        = LoginService()// Singleton for a unique currentUser Instance
    private var user                 = User()
    private let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func Login(username:String,password:String,completionHandler:LoginCompletionHandler){
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userUsername == %@ AND userPassword == %@", username, password)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchUser    = fetchResults.finalResult as! [User]
            if fetchUser.count > 0 {
                self.user = fetchUser[0]
                NSUserDefaults.standardUserDefaults().setValue(self.user.userUsername, forKey: "UserSession")
                completionHandler!(logged: true,error: nil)
            }else{
                completionHandler!(logged: false,error: "Wrong credentials!")
            }
        }catch{
            completionHandler!(logged: false,error: "CoreData error!")
        }
    }
    
    func retrieveSession(completion:RetrievingCompletionHandler){
        let session = NSUserDefaults.standardUserDefaults().stringForKey("UserSession")
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userUsername == %@", session!)
        do{
            let fetchResults = try managedObjectContext.executeRequest(fetchRequest) as! NSAsynchronousFetchResult
            let fetchUser    = fetchResults.finalResult as! [User]
            if fetchUser.count > 0 {
                self.user = fetchUser[0]
                completion!(error: nil)
            }else{
                completion!(error: "Session expired!")
            }
        }catch{
            completion!(error: "CoreData error!")
        }
    }
    
    func checkSession()->Bool{
        let session = NSUserDefaults.standardUserDefaults().stringForKey("UserSession")
        if(session != nil){
            return true
        }else{
            return false
        }
    }
    
    func Logout(){
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "UserSession")
    }
}