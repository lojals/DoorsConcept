//
//  DoorServerSimulator.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/21/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

protocol DoorServerSimulatorResponse{
    func doorServerOpenedDoor(opened:Bool)
    func doorJustClosed()
}
class DoorServerSimulator: NSObject{
    var doorInteractor:DoorsInteractor = DoorsInteractor()
    let responseDelegate:DoorServerSimulatorResponse?
    
    init(responseDelegate:DoorServerSimulatorResponse){
        self.responseDelegate = responseDelegate
        super.init()
    }
    
    /**
     Check with the interactor if user has enough permissions to access to an specific door
     
     - parameter door: valid door
     - parameter user: valid user
     */
    func openDoor(door:Door, user:User){
        doorInteractor.checkPermission(user, door: door) { (data, error) -> Void in
            if error != nil{
                let _ = NSTimer.scheduledTimerWithTimeInterval(1.7, target: self, selector: Selector("sendResponseDenied"), userInfo: nil, repeats: false)
            }else{
                let _ = NSTimer.scheduledTimerWithTimeInterval(1.7, target: self, selector: Selector("sendResponseAccessed"), userInfo: nil, repeats: false)
            }
        }
    }
    
    /**
     Fake server send a denied response, after 1.5 is ready to accept new petitions.
     */
    func sendResponseDenied(){
        responseDelegate?.doorServerOpenedDoor(false)
        let _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("doorIsClosed"), userInfo: nil, repeats: false)
    }
    
    /**
     Fake server send a Accessed response, after 3 seconds the door is closed and can to accept new petitions.
     */
    func sendResponseAccessed(){
        responseDelegate?.doorServerOpenedDoor(true)
        let _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("doorIsClosed"), userInfo: nil, repeats: false)
    }
    
    /**
     The door is closed and sent as response.
     */
    func doorIsClosed(){
        responseDelegate?.doorJustClosed()
    }
    
}
