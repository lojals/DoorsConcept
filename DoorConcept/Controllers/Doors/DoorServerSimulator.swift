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
    
    func openDoor(door:Door, user:User){
        doorInteractor.checkPermission(user, door: door) { (data, error) -> Void in
            if error != nil{
                print("error")
                let _ = NSTimer.scheduledTimerWithTimeInterval(1.7, target: self, selector: Selector("sendResponseDenied"), userInfo: nil, repeats: false)
            }else{
                let _ = NSTimer.scheduledTimerWithTimeInterval(1.7, target: self, selector: Selector("sendResponseAccessed"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func sendResponseDenied(){
        responseDelegate?.doorServerOpenedDoor(false)
        let _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("doorIsClosed"), userInfo: nil, repeats: false)
    }
    
    func sendResponseAccessed(){
        responseDelegate?.doorServerOpenedDoor(true)
        let _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("doorIsClosed"), userInfo: nil, repeats: false)
    }
    
    func doorIsClosed(){
        responseDelegate?.doorJustClosed()
    }
    
}
